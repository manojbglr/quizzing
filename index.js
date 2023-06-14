const { check, validationResult }
	= require('express-validator');

const bodyparser = require('body-parser')
const express = require("express")
const path = require('path')
const app = express()

const {getUsers, getUserByusername, createUser, getPasscode} = require('./queries.js');
const { checkPassword } = require('./passwordencrypt.js');

var PORT = process.env.port || 3000

// View Engine Setup
app.set("views", path.join(__dirname))
app.set("view engine", "ejs")

// Body-parser middleware
app.use(bodyparser.urlencoded({ extended: false }))
app.use(bodyparser.json())

app.get("/api/welcome", function (req, res) {
	res.render("SampleForm");
})

app.get("/api/login", function (req, res) {
	res.render("login");
})

app.get("/users", function (req, res) {
	getUsers(req,res);
})

app.get("/user/:email", function (req, res) {
	console.log("Fetching user details for" + req.params.email);
	getUserByusername(req,res);
})

app.post("/api/login", [
	check('email', 'Email length should be 10 to 30 characters')
	.isEmail().isLength({ min: 10, max: 30 }),
	check('passcode', 'Password length should be 8 to 10 characters')
	.isLength({ min: 8, max: 14 })
],
    (req, res) =>{
		const errors = validationResult(req);

	// If some error occurs, then this
	// block of code will run
	if (!errors.isEmpty()) {
		
		res.json(errors)
	}
	else{
		const {email,passcode} = req.body
		
		const dbpassword = getPasscode(email);
		console.log("Password from db "+dbpassword);
	    checkPassword(passcode,dbpassword).then(response=>{
		res.status(201).send(`${response}`);
	})
	}
});

// check() is  used to validate
// the incoming data as per the fields

app.post('/api/signup', [
	check('email', 'Email length should be 10 to 30 characters')
					.isEmail().isLength({ min: 10, max: 30 }),
	check('name', 'Name length should be 10 to 20 characters')
					.isLength({ min: 10, max: 20 }),
	check('mobile', 'Mobile number should contains 10 digits')
					.isLength({ min: 10, max: 10,Number:10 }),
	check('passcode', 'Password length should be 8 to 10 characters')
					.isLength({ min: 8, max: 14 })
					
], (req, res) => {

	// validationResult function checks whether
	// any occurs or not and return an object
	console.log("Validating request body");
	const errors = validationResult(req);

	// If some error occurs, then this
	// block of code will run
	if (!errors.isEmpty()) {
		
		res.json(errors)
	}

	// If no error occurs, then this
	// block of code will run
	else {
		createUser(req,res);
		//res.send("Successfully Authenticated")
	}
});

app.listen(PORT, function (error) {
	if (error) throw error
	console.log("Server created Successfully on PORT ", PORT)
})
