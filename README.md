# Serendipitous Gem

Asks you contextual questions about content created from simple JSON.

TODO

 - [ ] Make data suggestions on content
 - [ ] Point out data problems with content
 - [ ] Create a writing prompt about content

# Usage

```
irb(main):001:0> require 'serendipitous'
=> true
irb(main):002:0> alice = Content.new({ title: 'Alice', description: 'MC', age: '', best_friend: '' })
=> #<Content:0x005601b1bacb48 @data={:type=>"Character", :title=>"Alice", :description=>"MC", :age=>"", :best_friend=>""}>
irb(main):003:0> QuestionService.question(alice)
=> "What is Alice's age?"
irb(main):004:0> QuestionService.question(alice)
=> "Who is Alice's best friend?"
irb(main):005:0> alice.data[:best_friend] = 'Bob'
=> "Bob"
irb(main):006:0> QuestionService.question(alice)
=> "When did Alice meet Bob?"
```
