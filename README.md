# GitHub events router DSL

Extensible webhook for processing GitHub events based on custom DSL.

Examples:

```ruby
GitHub.rules do
  rule do
    on :repo, 's12v/sandbox'
    on :label, 'Please review'
    action :slack, to: '#test', template: 'please_review'
  end

  rule do
    on :repo, 's12v/sandbox'
    on :release
    action :slack, to: '#test', template: 'new_release'
  end
```

