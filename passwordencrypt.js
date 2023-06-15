
const bcrypt = require('bcryptjs');

async function hashPassword(original_password){
    const hashedPass = await bcrypt.hash(original_password, 10);
    return hashedPass; //returns [object Promise]
}

async function checkPassword(submitted_password,dbpassword,callback){
bcrypt.compare(submitted_password,dbpassword, function(err, res) {
    if (err){
      console.log("Exception matching password")  
    }
    callback(res)
    })

}

    module.exports = {
        hashPassword,
        checkPassword,
      }