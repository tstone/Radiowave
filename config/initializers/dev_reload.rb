
# Re-run the blog scanner initializer in dev mode
# otherwise when Rails reloads the Ruby class the data
# gets lost and things blow up.

if Rails.env.development?
  ActionDispatch::Callbacks.after do
    puts "GOT HERE"
    Dir.entries("#{Rails.root}/lib").each do |entry|
      load entry if entry =~ /^\d\d_/
    end
  end
end
