Given /the following countries exist:/ do |countries|
  user =  User.last
  countries.hashes.each do |hash|
    visited = hash.delete('visited')
    country = Country.create!(hash)
    if visited == 'true'
      country.visit(user)
    end
  end

end

Then /^I should see the following table:$/ do |expected_table|
  document = Nokogiri::HTML(page.body)
  rows = document.css('section>table tr').collect { |row| row.xpath('.//th|td').collect {|cell| cell.text } }
  expected_table.diff!(rows)
end
