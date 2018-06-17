const express = require('express')
const router = express.Router()
const { check, validationResult } = require('express-validator/check')
const { matchedData } = require('express-validator/filter')
const changeCase = require('change-case')

router.get('/', (req, res) => {
  res.render('index', {
    data: {},
    errors: {}
  })
})


router.post('/', [
  check('name')
    .isLength({ min: 3 })
    .withMessage('Name is required')
    .trim(),
], (req, res) => {
  const errors = validationResult(req)

  if (!errors.isEmpty()) {
   return res.render('index', {
     data: req.body,
     errors: errors.mapped()
   })
 } else {
   const data = matchedData(req)
   console.log('Sanitized:', data)
   var instance_name = changeCase.snakeCase(data.name);
   create_instsance(instance_name)
   req.flash('success', 'Your instance will set up now!')
   res.render('instance', {
     data: {
       "instance_name": instance_name
     },
     errors: {}
   })
 }

})

create_instsance = function(instance_name) {


  var util    = require('util'),
    spawn   = require('child_process').spawn,
    carrier = require('carrier'),
    pl_proc = spawn('perl', ['magic.pl', instance_name]),
    my_carrier;

    my_carrier = carrier.carry(pl_proc.stdout);

    my_carrier.on('line', function(line) {
    // Do stuff...
    console.log('instance_name: ' + line);
})
}

module.exports = router
