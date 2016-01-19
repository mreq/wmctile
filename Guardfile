guard :rubocop do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard :yard do
  watch(/.+\.rb$/)
end

guard :minitest do
  watch(%r{^spec/(.*)_spec\.rb$})
  watch(%r{^lib/(.+\/)?(.+)\.rb$})  { |m| "spec/#{m[2]}_spec.rb" }
  watch(%r{^spec/spec_helper\.rb$}) { 'spec' }
end
