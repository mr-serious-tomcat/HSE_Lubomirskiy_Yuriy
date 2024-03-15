import json
import re

def extract_emails_from_text(text):
    return re.findall(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b', text)

def find_emails_in_messages(messages):
    emails_dict = {}

    for message in messages:
        inn = message.get('publisher_inn')
        msg_text = message.get('msg_text')

        if inn not in emails_dict:
            emails_dict[inn] = set()

        emails = extract_emails_from_text(msg_text)
        if emails:
            emails_dict[inn].update(set(emails))

    return emails_dict


with open('1000_efrsb_messages.json', 'r') as file:
    messages = json.load(file)

emails_dict = find_emails_in_messages(messages)

with open('emails.json', 'w') as output_file:
    json.dump(emails_dict, output_file, indent=4)

print("Email-сохранены в файл emails.json")