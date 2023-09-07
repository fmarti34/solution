require 'time'

input_data = "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"

def solution(photo_data)
  file_name_map = Hash.new
  entries = photo_data.strip.split("\n")

  begin
    city_group = group_by_city(entries)
  rescue StandardError => e
    return "Error in group_by_city: #{e.message}"
  end

  city_group.each do |city, values|
    count = 1
    leading_0s_length = values.length.to_s.length

    values.sort_by { |e| e[1] }.each do |val|
      file_name_map[val[0]] = city + format("%0#{leading_0s_length}d", count) + "." + val[0].split(".")[1]
      count += 1
    end
  end

  entries.map { |entry| file_name_map[entry.strip.split(', ')[0]] }.join("\n")
end

def group_by_city(entries)
  city_group = Hash.new { |h, k| h[k] = [] }

  entries.each do |entry|
    entry_parts = entry.strip.split(', ')

    raise "Invalid input string: #{entry}" if entry_parts.length != 3

    file_name, location, time = entry_parts[0], entry_parts[1], Time.parse(entry_parts[2])
    city_group[location] << [file_name, time]
  end

  city_group
end

puts solution(input_data)
