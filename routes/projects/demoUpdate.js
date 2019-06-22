/*eslint-disable */

const express = require('express');
const router = express.Router({ mergeParams: true });
const ADALService = require('../../utils/ADALServices');
const crmWebAPI = require('../../utils/crmWebAPI');


router.patch('/', async (req, res) => {
    let { params, body } = req;
    const { id } = params;

    crmWebAPI.update('dcp_projectmilestones', id, body);

    res.send(`patch route hit: ${id}`);
});

module.exports = router;