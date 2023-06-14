
const bcrypt = require('bcryptjs');

async function hashPassword(original_password){
    const hashedPass = await bcrypt.hash(original_password, 10);
    return hashedPass; //returns [object Promise]
}

async function checkPassword(submitted_password,dbpassword){
bcrypt.compare(submitted_password, 10, function(err, res) {
    if(submitted_password != dbpassword){
      res.json({success: false, message: 'passwords do not match'});
    } else {
        res.json({success: true, message: 'passwords  matched'});
      // invoke an catboy api and populate the success message
    }
  });}

    module.exports = {
        hashPassword,
        checkPassword,
      }