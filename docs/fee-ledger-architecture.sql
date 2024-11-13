-- EduAngon ERP: Multi-Stream Student Accounting & Fee Ledger Schema
-- Designed for Schools, Madrasas & Coaching Centers

CREATE TABLE IF NOT EXISTS academic_streams (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,                             -- 'General School', 'Madrasa', 'Coaching'
    stream_code TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS fee_heads (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,                            -- 'Monthly Tuition', 'Session Fee', 'Lab Fee'
    is_recurring INTEGER DEFAULT 1,
    default_amount DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS student_fee_ledgers (
    id TEXT PRIMARY KEY,
    student_id TEXT NOT NULL,
    fee_head_id TEXT NOT NULL REFERENCES fee_heads(id),
    due_month TEXT NOT NULL,                        -- YYYY-MM
    payable_amount DECIMAL(10, 2) NOT NULL,
    waiver_amount DECIMAL(10, 2) DEFAULT 0.00,
    net_amount DECIMAL(10, 2) NOT NULL,
    paid_amount DECIMAL(10, 2) DEFAULT 0.00,
    status TEXT CHECK(status IN ('unpaid', 'partial', 'paid')) DEFAULT 'unpaid',
    due_date DATE NOT NULL
);