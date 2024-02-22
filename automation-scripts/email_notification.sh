#!/bin/bash

send_email_notification() {
    echo "Sending email notification..."
    SUBJECT="System Report"
    TO="your_email@example.com"
    BODY="System cleanup completed successfully."

    echo "$BODY" | mail -s "$SUBJECT" "$TO"
    echo "Email notification sent."
}

send_email_notification