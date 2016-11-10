alphabet = Hash[('a'..'z').zip(1..26)]

examples = ["a", "e", "i", "o", "u", "y"]

vowels = alphabet.map { |key, n| "#{key} - #{n}" if examples.include?(key) }

puts vowels.compact


