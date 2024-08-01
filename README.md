# stackspot-review

## Prompt na LLM

Your answer should just follow the JSON structure below:

```json
[
  {
    "title": "<title>",
    "severity": "&lt;SEVERITY&gt;",
    "correction": "&lt;CORRECTION&gt;"
  }
]

Claro, aqui está o código formatado para ser colado em um README no GitHub:

```markdown
## Prompt na LLM

Your answer should just follow the JSON structure below:

```json
[
  {
    "title": "<title>",
    "severity": "&lt;SEVERITY&gt;",
    "correction": "&lt;CORRECTION&gt;"
  }
]
```

Where the "title" would be a string summarizing the vulnerability in 15 words maximum.

Where the "severity" would be a string representing the impact of the vulnerability, using critical, high, medium, or low.

Where the "correction" would be a code suggestion to resolve the issue identified, without code.

Check security vulnerabilities describe the vulnerabilities and fix the selected code `{{input_data}}`.
```