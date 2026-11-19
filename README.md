# terraform-lab

My Terraform practice, lesson by lesson. Comments in the files are in Polish.

I used Claude Code as a tutor: it prepared each lesson's starting files with TODOs, explained concepts, and reviewed my code. The solutions are mine.

| Lesson | Topic |
|---|---|
| lekcja-1 | First resources (Docker provider), plan / apply / destroy, ForceNew |
| lekcja-2 | Variables with validation, outputs |
| lekcja-3 | `for_each`, `for` expressions, `for_each` vs `count` |
| lekcja-4 | Modules: inputs, outputs, calling one module twice |
| lekcja-5 | New Relic provider: alert policy, NRQL condition, synthetic monitor, dashboard |
| lekcja-6 | `import` blocks and `-generate-config-out` |
| lekcja-7 | Remote state in Postgres (`pg` backend) and state locking |

Everything runs locally on Docker, except lesson 5, which needs a New Relic account. Credentials come from environment variables, never from the code.
