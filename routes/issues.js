const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const Issue = require('../models/Issue');
const { authenticate } = require('./auth');
const { body, validationResult } = require('express-validator');

// Configure multer for file uploads
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'public/images/uploads/');
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + '-' + file.originalname);
    }
});
const upload = multer({ storage: storage, limits: { fileSize: 5 * 1024 * 1024 } });

// Get all issues (with filters)
router.get('/', authenticate, async (req, res) => {
    try {
        const { status, issueType, priority, userId } = req.query;
        const filter = {};

        if (status) filter.status = status;
        if (issueType) filter.issueType = issueType;
        if (priority) filter.priority = priority;
        if (userId) filter.userId = userId;

        const issues = await Issue.find(filter)
            .populate('userId', 'name email')
            .populate('assignedTo', 'name email')
            .sort({ createdAt: -1 });

        res.json(issues);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

// Get dashboard statistics
router.get('/stats', authenticate, async (req, res) => {
    try {
        const totalIssues = await Issue.countDocuments();
        const pendingIssues = await Issue.countDocuments({ status: 'pending' });
        const inProgressIssues = await Issue.countDocuments({ status: 'in-progress' });
        const resolvedIssues = await Issue.countDocuments({ status: 'resolved' });
        const closedIssues = await Issue.countDocuments({ status: 'closed' });

        const issuesByType = await Issue.aggregate([
            { $group: { _id: '$issueType', count: { $sum: 1 } } }
        ]);

        const issuesByPriority = await Issue.aggregate([
            { $group: { _id: '$priority', count: { $sum: 1 } } }
        ]);

        const recentIssues = await Issue.find()
            .populate('userId', 'name email')
            .sort({ createdAt: -1 })
            .limit(10);

        const issuesByStatus = [
            { status: 'pending', count: pendingIssues },
            { status: 'in-progress', count: inProgressIssues },
            { status: 'resolved', count: resolvedIssues },
            { status: 'closed', count: closedIssues }
        ];

        res.json({
            totalIssues,
            issuesByStatus,
            issuesByType,
            issuesByPriority,
            recentIssues
        });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

// Get single issue
router.get('/:id', authenticate, async (req, res) => {
    try {
        const issue = await Issue.findById(req.params.id)
            .populate('userId', 'name email')
            .populate('assignedTo', 'name email');

        if (!issue) {
            return res.status(404).json({ message: 'Issue not found' });
        }

        res.json(issue);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

// Create new issue
router.post('/', authenticate, upload.array('photos', 5), [
    body('issueType').isIn(['sanitation', 'roads', 'water', 'safety', 'other']).withMessage('Invalid issue type'),
    body('description').trim().notEmpty().withMessage('Description is required'),
    body('location.address').trim().notEmpty().withMessage('Location address is required'),
    body('location.coordinates.lat').isNumeric().withMessage('Valid latitude is required'),
    body('location.coordinates.lng').isNumeric().withMessage('Valid longitude is required')
], async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }

        const photos = req.files ? req.files.map(file => `/images/uploads/${file.filename}`) : [];

        const issue = new Issue({
            ...req.body,
            userId: req.userId,
            photos
        });

        await issue.save();
        await issue.populate('userId', 'name email');

        res.status(201).json(issue);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

// Update issue
router.put('/:id', authenticate, async (req, res) => {
    try {
        const { status, priority, department, assignedTo, resolutionNotes } = req.body;

        const issue = await Issue.findById(req.params.id);
        if (!issue) {
            return res.status(404).json({ message: 'Issue not found' });
        }

        if (status) issue.status = status;
        if (priority) issue.priority = priority;
        if (department) issue.department = department;
        if (assignedTo) issue.assignedTo = assignedTo;
        if (resolutionNotes) issue.resolutionNotes = resolutionNotes;

        if (status === 'resolved' || status === 'closed') {
            issue.resolvedAt = new Date();
        }

        await issue.save();
        await issue.populate('userId', 'name email');
        await issue.populate('assignedTo', 'name email');

        res.json(issue);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

// Delete issue
router.delete('/:id', authenticate, async (req, res) => {
    try {
        const issue = await Issue.findByIdAndDelete(req.params.id);
        if (!issue) {
            return res.status(404).json({ message: 'Issue not found' });
        }

        res.json({ message: 'Issue deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error: error.message });
    }
});

module.exports = router;

