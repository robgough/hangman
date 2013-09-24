describe 'playing hangman' do
	it 'displays a masked word' do
		play("hangman")
		expect(placeholder.to_s).to eq("_______")
	end

	it 'reveals letters guessed correctly' do
		word = "hangman"
		play(word)

		placeholder.make_guess("h")
		expect(placeholder.to_s).to eq("h______")

		placeholder.make_guess("a")
		expect(placeholder.to_s).to eq("ha___a_")
	end

	it 'ignores incorrect guesses' do
		word = "hangman"
		play(word)

		placeholder.make_guess("i")
		expect(placeholder.to_s).to eq("_______")
	end

	it 'returns false if incorrect guess' do
		word = "hangman"
		play(word)

		expect(placeholder.make_guess("i")).to be_false
	end

	it 'knows when it is not completed' do
		word = "hangman"
		play(word)

		placeholder.make_guess("h")
		expect(placeholder.completed).to eq(false)
	end

	it 'knows when it has completed' do
		word = "hangman"
		play(word)

		placeholder.make_guess("h")
		placeholder.make_guess("a")
		placeholder.make_guess("n")
		placeholder.make_guess("g")
		placeholder.make_guess("m")
		placeholder.make_guess("n")

		expect(placeholder.completed).to eq(true)
	end

	def play(word)
		@placeholder = Placeholder.new(word)
	end

	def placeholder
		@placeholder
	end

	class Placeholder
		def initialize(word)
			@word = word
			@placeholder = "_" * @word.size
		end

		def make_guess(guess)
			@word.chars.each_with_index do |char, index|
				update_placeholder(index, guess) if char == guess
			end
			!!@word[guess]
		end

		def update_placeholder(index, guess)
			self[index] = guess
		end

		def []=(index, char)
			@placeholder[index] = char
		end

		def completed
			!@placeholder.include?("_")
		end

		def to_s
			@placeholder
		end
	end
end