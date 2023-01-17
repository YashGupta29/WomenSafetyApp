const express = require('express');
const auth = require('../../middlewares/auth');
const validate = require('../../middlewares/validate');
const contactValidation = require('../../validations/contact.validation');
const contactController = require('../../controllers/contact.controller');

const router = express.Router();

router.route('/').post(auth('manageContacts'), validate(contactValidation.createContact), contactController.createContact);

router.route('/all').get(auth('getContacts'), validate(contactValidation.getContacts), contactController.getContacts);

router
  .route('/:contactId')
  .delete(auth('manageContacts'), validate(contactValidation.deleteContact), contactController.deleteContact);

module.exports = router;
