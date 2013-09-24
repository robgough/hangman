describe 'playing hangman' do
	it 'displays a masked word' do
		play("hangman")
		expect(placeholder).to eq("_______")
	end

	it 'reveals letters guessed correctly' do
		word = "hangman"
		play(word)

		make_guess(placeholder, word, "h")
		expect(placeholder).to eq("h______")

		make_guess(placeholder, word, "a")
		expect(placeholder).to eq("ha___a_")
	end

	def play(word)
		@placeholder = Placeholder.new(word).to_s
	end

	def placeholder
		@placeholder.to_s
	end

	def update_placeholder(placeholder, index, guess)
		placeholder[index] = guess
	end

	def make_guess(placeholder, word, guess)
		word.chars.each_with_index do |char, index|
			update_placeholder(placeholder, index, char) if char == guess
		end
	end

	class Placeholder
		def initialize(word)
			@word = word
		end

		def to_s
			"_" * @word.size
		end
	end
end