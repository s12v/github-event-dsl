# GitHub events router

Extensible webhook for processing GitHub events based on rules in a simple Ruby DSL.

Example:
```ruby
rule do
  on :repo, 's12v/github-event-router'
  on :label, 'question'
  action :slack, to: '#test', template: 'question'
end
```
