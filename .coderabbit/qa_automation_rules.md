# QA Automation Rules — SimplePractice
Ruby · RSpec · SitePrism

These rules define the expected standards for QA automation tests.
They are enforced automatically during PR reviews.

---

## R-1: describe must use the title variable

### Rule
RSpec `describe` blocks must use the `title` variable instead of hardcoded string literals.

### Why
Keeps test names consistent with TestRail and avoids naming drift.

### Signals of violation
- `describe` using a quoted string literal
- Test title not matching TestRail case name

### Incorrect
```ruby
describe 'Sample automation test' do
```

**Correct**
```ruby
describe title do
```

## R-2: One behavior per it

### Rule
Each `it` block must validate a single behavior or intention.

### Why
Multiple behaviors in one example reduce readability and make failures harder to diagnose.

### Signals of violation
- More than 4–5 expectations
- Multiple flows or state changes in one example

### Fix
Split into multiple `it` blocks or separate `context`s.

---

## R-3: Avoid before(:all) with mutable state

### Rule
Do not use `before(:all)` when the data is modified inside `it` blocks.

### Why
Mutable shared state causes flaky tests and cross-test pollution.

### Incorrect
```ruby
before(:all) do
  @client = create_client
end

it 'updates client' do
  @client.update(name: 'John')
end
```

### Correct
```ruby
before do
  client = create_client
end
```

## R-4: Do not use instance variables scoped only to one it

### Rule
If a variable is only used inside a single `it`, it must be defined locally.

### Why
Instance variables imply shared state and make tests harder to reason about.

### Incorrect
```ruby
it 'shows completed measure' do
  @today_date = Time.now
end
```

### Correct
```ruby
it 'shows completed measure' do
  today_date = Time.now
end
```

## R-5: Avoid trivial or tautological expectations

### Rule
Expectations that always pass (for example `expect(1).to eq(1)`) are not allowed.

### Why
They provide no validation of user-visible behavior and give false confidence.

### Fix
Replace with assertions that validate:
- UI state
- Element visibility or disabled state
