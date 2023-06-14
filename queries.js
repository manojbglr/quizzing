const Pool = require('pg').Pool
const encrypter = require('./passwordencrypt').hashPassword
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'postgres',
  password: 'postgres',
  port: 5432,
})
const getUsers = (request, response) => {
  pool.query('SELECT username,email,mobileno FROM public."user"', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getPasscode = (usr) => {
  const email = usr;
  console.log("checking for email:"+usr)
  pool.query('SELECT username FROM public."user" WHERE email = $1', [email],(error, results) => {
    if (error) {
      throw error
    }
    
    console.log("Result is "+results.rows);
    return results.rows
    
  })
}

const getUserByusername = (request, response) => {
  const email = request.params.email

  pool.query('SELECT username,email,mobileno FROM public."user" WHERE email = $1', [email], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const createUser = (request, response) => {
  const { name, email,mobile,passcode } = request.body
  encrypter(passcode).then(password=>
    
  
  pool.query('INSERT INTO public."user" (username, email,mobileno,password) VALUES ($1, $2,$3,$4)', [name, email,mobile,password], (error, results) => {
    if (error) {
      response.status(500).send(`Exception encoutered while adding user: ${error.message}`)
    }
    else {
      const mesg = '{success: true,message: “Signed up successfully”}'; 
      response.status(201).send(`${mesg}`);
    }
  }))
}

const updateUser = (request, response) => {
  const id = parseInt(request.params.id)
  const { name, email } = request.body

  pool.query(
    'UPDATE users SET name = $1, email = $2 WHERE id = $3',
    [name, email, id],
    (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).send(`User modified with ID: ${id}`)
    }
  )
}

const deleteUser = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('DELETE FROM users WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).send(`User deleted with ID: ${id}`)
  })
}

module.exports = {
  getUsers,
  getUserByusername,
  createUser,
  updateUser,
  deleteUser,
  getPasscode,
}