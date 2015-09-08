# GitHub events router

Extensible webhook for processing GitHub events based on rules in a simple Ruby DSL.

Example:
```ruby
rule do
  on :repo, 's12v/sandbox'
  on :label, 'question'
  action :slack, to: '#test', template: 'question'
end
```
