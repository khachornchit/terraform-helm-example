const express = require('express');
const Contact = require('../models/Contact');
const router = express.Router();

router.get('/contacts', (req, res, next) => {
    Contact.find(function (err, contacts) {
        res.json(contacts);
    })
});

router.post('/contacts', (req, res, next) => {
    let contact = new Contact({
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        phone: req.body.phone
    });

    contact.save((err, contact) => {
        if (err) {
            res.json({
                msg: 'Failed to add contact !!!'
            });
        } else {
            res.json(contact);
        }
    });
});

router.get('/contacts/:id', (req, res, next) => {
    Contact.find(
        {
            _id: req.params.id
        }, function (err, results) {
            if (err) {
                res.json(err);
            } else {
                res.json(results);
            }
        })
});

router.delete('/contacts/:id', (req, res, next) => {
    Contact.remove(
        {
            _id: req.params.id
        }, function (err, results) {
            if (err) {
                res.json(err);
            } else {
                res.json(results);
            }
        })
});

router.put('/contacts/:id', (req, res, next) => {
    Contact.updateOne(
        {
            _id: req.params.id
        },
        {
            $set: {
                first_name: req.body.first_name,
                last_name: req.body.last_name,
                phone: req.body.phone,
            }
        },
        function (err, results) {
            if (err) {
                res.json(err);
            } else {
                Contact.find(
                    {
                        _id: req.params.id
                    }, function (err, results) {
                        if (err) {
                            res.json(err);
                        } else {
                            res.json(results);
                        }
                    })
            }
        });
});

module.exports = router;
