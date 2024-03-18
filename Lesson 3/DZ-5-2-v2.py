import json
import re

def extract_emails():
    email_pattern = re.compile(r'\b[\w\.-]+@[\w\.-]+\.[a-zA-Z]+\b')
    with open("10000_efrsb_messages.json", "r") as f:
        messages = json.load(f)
    results = {}
    for message in messages:
        inn = message.get('publisher_inn')
        if inn:
            emails = set(re.findall(email_pattern, message.get('msg_text', '')))
            results.setdefault(inn, []).extend(emails)
    save_emails_to_json(results)

def save_emails_to_json(email_dict):
    with open('emails.json', "w") as f:
        json.dump(email_dict, f)
