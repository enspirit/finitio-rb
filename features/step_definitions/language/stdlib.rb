Given(/^"(.*?)" has been registered as stdlib$/) do |name|
  Finitio.stdlib_path(Path.dir.parent.parent/"fixtures")
end
