#!/usr/bin/env python3

import os
import json
import requests

GHUSER = os.getenv('GITHUB_USER')
url = f'https://api.github.com/users/{GHUSER}/events'
print(GHUSER)

def retrieve_events(url):
	'''Retrieves github events from a given GitHub user's page,
	 returns a list of dictionaries'''
	api_output = requests.get(url).text
	return json.loads(api_output)

def print_events(events, n=5):
	'''Prints all events in an API output list/dict'''
	for x in events[:n]:
		event = x['type'] + ' :: ' + x['repo']['name']
		print(event)

def main():
	print(GHUSER)
	print(url)
	github_events = retrieve_events(url)
	print_events(github_events, 10)

if __name__ == "__main__":
    main()
