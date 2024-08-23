# stackspot-review

## Prompt na LLM

Your answer should just be following the JSON structure below:

```json
{
  "summary": "<summary>",
  "descriptions": "<description>s"
}
```

Where the "summary" would be a string resuming the vulnerabilities in 15 words maximum.

Where the "descriptions" would be a the issues list identified, without code

Check security vulnerabilities describe the vulnerabilities {{input_data}}
