const Pool = require('pg').Pool
const pg = require('pg');
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
      console.log(error.message)
      return
    }
    response.status(200).json(results.rows)
  })
}

const getPasscode = (usr) => {
  const email = usr;
  console.log("checking for email:"+usr)
  pool.query('SELECT password FROM public."user" WHERE email = $1', [email],(error, results) => {
    if (error) {
      console.log(error.message)
      return
    }
    
    console.log("Result is "+results.rows);
    return results.rows[0].password
    
  })
}

const getUserByusername = (request, response) => {
  const email = request.params.email

  pool.query('SELECT username,email,mobileno FROM public."user" WHERE email = $1', [email], (error, results) => {
    if (error) {
      response.status(500).send(`Exception encoutered while getting user: ${error.message}`)
      return
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
      return
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
        console.log(error.message)
        return
      }
      response.status(200).send(`User modified with ID: ${id}`)
    }
  )
}

const deleteUser = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('DELETE FROM users WHERE id = $1', [id], (error, results) => {
    if (error) {
      console.log(error.message)
      return
    }
    response.status(200).send(`User deleted with ID: ${id}`)
  })
}

const getTests = (req,res) => {
  pool.query(
    'SELECT  testid,testname,testdescription,questioncount,totalmarks  FROM public."test"',
    
    (error, results) => {
      if (error) {
        console.log(error.message)
        return
      }
      res.status(200).json(results.rows)
    }
  )
}
 function getTestId(testname)  {
  console.log("Looking testid for :"+testname)
  pool.query(
    'SELECT  testid  FROM public."test" WHERE testname = $1',[testname],
    
    (error, results) => {
      if (error) {
        console.log(error.message)
        return
      }
      console.log("testid"+results.rows[0].testid)
      
    }
  )
  return results.rows[0].testid;
}


 async function getAttemptNumber(email,testid,callback) {

console.log("email is"+email)
  const rv = await pool.query(
    'SELECT  max(attemptno)  FROM public."usertest" WHERE username = $1 and testid = $2',[email,testid],
    
    (error, results) => {
      if (error) {
        console.log(error.message)
        return
      }
      console.log(results.rows[0].attemptno);
      
      
    }
  )
}

 function registerTest  (request, response,) {
  const { email,testname } = request.body
    pool.query(
      'SELECT  testid  FROM public."test" WHERE testname = $1',[testname],
      (error, results) => {
      if (error) {
        console.log(error.message)
        const mesg = `{success: false,message: "${email} Your test ${testname} Could not be found in Test Bank”}`; 
        response.status(200).send(`${mesg}`);
        return;
      }
        if (results.rowCount == 0)
        {
          const mesg = `{success: false,message: "${email} Your test ${testname} Could not be found in Test Bank”}`; 
          response.status(200).send(`${mesg}`);
          return;
        }
      
          console.log(results.rows[0].testid);     
          const testid= results.rows[0].testid
          console.log("Looking for test taken by :"+email);
        pool.query(
        'SELECT  count(*) as attemptcount FROM public."usertest" WHERE username = $1 and testid = $2',[email,testid],
      
      (error, results) => {
        if (error) {
          console.log(error.message)
          return;
        }
            console.log("RowCount:"+results.rowCount)
            if (results.rows[0].attemptcount == 0) 
            { 
               attemptno = 1;
               console.log("First Attempt :"+attemptno);
            }
            else {

              attemptno = parseInt(results.rows[0].attemptcount)+1
              console.log("Attempt No "+attemptno);
            }
                
          
            const dateTimeObject = new Date();
            const attemptedon=dateTimeObject.toLocaleDateString();
            //const attemptedon = `${dateTimeObject.getUTCFullYear()}`+'/'+`${'0'}${dateTimeObject.getMonth()}`.slice(-2) + '/' + `${'0'}${dateTimeObject.getDay()}`.slice(-2);
            const starttime = `${'0'}${dateTimeObject.getHours()}`.slice(-2) + ':' + `${'0'}${dateTimeObject.getMinutes()}`.slice(-2) +':' + `${'0'}${dateTimeObject.getSeconds()}`.slice(-2);
            console.log(`Date: ${attemptedon}`);
            console.log(`Time: ${starttime}`);
            let score = 0;
            let percent = 0;
            //let sql = 'INSERT INTO public."usertest" (username,testid,attemptno,attemptedon,score,percent,starttime) VALUES ($1, $2,$3,TO_DATE($4,&quot;YYYY/MM/DD&quot;),$5,$6,TO_TIMESTAMP($7,&quot;HH:MI:SS&quot;))';
            let sql = 'INSERT INTO public."usertest" (username,testid,attemptno,attemptedon,score,percent,starttime) VALUES ($1, $2,$3,$4,$5,$6,$7)';
        
          //let sql = 'INSERT INTO public."usertest" (username,testid,attemptno,TO_DATE(attemptedon,&quot;YYYY/MM/DD&quot;),score,percent,TO_TIMESTAMP(starttime,&quot;HH24:MI:SS&quot;)) VALUES ($1, $2,$3,$4,$5,$6,$7)';
            console.log(sql);
            pool.query(sql, [email,testid,attemptno,attemptedon,score,percent,starttime], (error, results) => {
            if (error) {
              response.status(500).send(`Exception encoutered while test registration user: ${error.message}`)
            }
            else {
              const mesg = `{success: true,message: "${email} Your test ${testname} started at ${attemptedon} ${starttime}”}`; 
              response.status(201).send(`${mesg}`);
            }
          })        
      })
        
    }
    
  )

   
}


function getQuestiondtls(qid,res){
  
  console.log("question ID :"+qid);
  pool.query(
    'SELECT  qtext  FROM public."questionbank" WHERE questionid = $1',[qid],
    (error, results) => {
      if ( error){
        console.log(error.message)
        const mesg = `{success: false, message: "System error”}`; 
        res.status(500).send(`${mesg}`);
        return;
      }
    if (results.rowCount == 0) {
      
      const mesg = `{success: false, message: "Invaid question id”}`; 
      res.status(500).send(`${mesg}`);
      return;
    }
    
    question = results.rows[0].qtext;
    console.group("Question is "+question)
    pool.query(
      'SELECT  questionkey , keytext FROM public."answerkey" WHERE questionid = $1',[qid],
      (error,results) => {
        if ( error){
          console.log(error.message)
          const mesg = `{success: false, message: "System error”}`; 
          res.status(500).send(`${mesg}`);
          return;
        }
        if ( results.rowCount == 0) {
        console.log(error.message)
        const mesg = `{success: false,message: "Question Setup Error”}`; 
        res.status(200).send(`${mesg}`);
        return;
        }
        var qheader = "{\"questionid\":"+qid+",\"Question\":\""+question+"\",\"QKey\":\"\"}";
        console.log(qheader);
        var json = JSON.parse(qheader);
        var obj = [];
       for ( i = 0; i < results.rowCount; i++){
          
              var questiondtl = {};           // Object
              questiondtl['questionkey'] = results.rows[i].questionkey ;
              questiondtl['keytext'] = results.rows[i].keytext ;  
              obj.push(questiondtl);              
        }
           
        json["QKey"]=obj;
        var jsonstr = JSON.stringify(json, undefined, 2);    
       
        res.status(200).send(jsonstr);
        }
    )
    
    }
)}

function registeranswer  (request, response,) {
  console.log(request.body)
  const { email,testid, questionid,answers} = request.body
  let keyseq = answers.split(','); 
  //keyseq.push(answers)
   
   var answerseq="";
   
    for ( i = 0; i < keyseq.length ; i++){
      answerseq = answerseq+keyseq[i];
    }
    console.log(answerseq)
            const dateTimeObject = new Date();
            const attemptedon=dateTimeObject.toLocaleDateString();
            console.log(attemptedon)
    pool.query(
      'INSERT INTO public."userrecord" ( username,testid,questionid,keysequence,date,locked) VALUES ($1,$2,$3,$4,$5,$6)',
      [email,testid,questionid,answerseq,attemptedon,true],
       
      (error, results) => {
      if (error) {
        console.log(error.message)
        const mesg = `{success: false,message: "${email} Your answer could not be registered because of ${error.message}”}`; 
        response.status(200).send(`${mesg}`);
        return;
      }
       
      const mesg = `{success: true,message: "${email} Your answer for ${questionid} submitted successfully”}`; 
      response.status(201).send(`${mesg}`);
             
          })        
     
        
    }
    
  

   


module.exports = {
  getUsers,
  getUserByusername,
  createUser,
  updateUser,
  deleteUser,
  getPasscode,
  getTests,
  registerTest,
  getQuestiondtls,
  registeranswer,
}