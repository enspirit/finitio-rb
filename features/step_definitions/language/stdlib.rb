Given(/^"(.*?)" has been registered as stdlib$/) do |name|
  Finitio.clear_saved_systems!
  Finitio.stdlib_path(Path.dir.parent.parent/"fixtures")
end
