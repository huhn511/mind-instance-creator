const express = require('express')
const router = express.Router()
const { check, validationResult } = require('express-validator/check')
const { matchedData } = require('express-validator/filter')

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
   req.flash('success', 'Your instance will set up now!')
   res.render('instance', {
     data: {},
     errors: {}
   })
 }

})
module.exports = router
