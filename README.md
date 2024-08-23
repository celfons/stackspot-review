# stackspot-review

## Prompt na LLM

Your answer should just be following the JSON structure below:

```json

[{
"title": "<title>",
"problem": "<problem>"
}]

Where the "title" would be a string resuming the vulnerability in 15 words maximum.

Where the "problem" would be a the issue identified, without code

Check security vulnerabilities describe the vulnerabilities {{input_data}}
