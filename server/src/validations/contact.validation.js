const Joi = require('joi');
const { objectId } = require('./custom.validation');

const createContact = {
  body: Joi.object().keys({
    name: Joi.string().required(),
    number: Joi.string().required(),
  }),
};

const getContacts = {
  query: Joi.object().keys({
    name: Joi.alternatives().try(Joi.string(), Joi.array()),
    sortBy: Joi.string(),
    limit: Joi.number().integer(),
    page: Joi.number().integer(),
  }),
};

const deleteContact = {
  params: Joi.object().keys({
    contactId: Joi.string().custom(objectId),
  }),
};

module.exports = {
  createContact,
  getContacts,
  deleteContact,
};
