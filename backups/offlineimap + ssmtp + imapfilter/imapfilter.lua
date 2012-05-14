# Automatically clean your Trash&Spam folders. Please make sure to have imapfilter installed, then run it using the following config file through a cronjob.

options.timeout = 120
options.subscribe = true

account = IMAP {
	   	server = 'imap.gmail.com',
		username = 'example@gmail.com',
		password = 'yourpassword',
		ssl = 'ssl3'
	}

trash = account['[Gmail]/Cestino']:is_undeleted()
account['[Gmail]/Cestino']:delete_messages(trash)

spam = account['[Gmail]/Spam']:is_unanswered()
account['[Gmail]/Spam']:delete_messages(spam)

