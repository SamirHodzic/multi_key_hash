RSpec.describe MultiKeyHash do
  it 'has a version number' do
    expect(MultiKeyHash::VERSION).not_to be nil
  end

  describe '#new' do
    let(:payload) do
      {
        %w[one two three] => 'number',
        %i[a b c] => 'letter',
        'single' => 'value'
      }
    end
    let(:multi_hash) { described_class.new(payload) }

    context 'creates hash' do
      it 'when accessing to multi keys' do
        expect(multi_hash['one']).to eq 'number'
        expect(multi_hash[:a]).to	eq 'letter'
        expect(multi_hash['single']).to eq 'value'
      end
    end

    context 'modifies hash' do
      it 'modifying defined multi key (string)' do
        multi_hash['one'] = 'first_number'

        expect(multi_hash['one']).to eq 'first_number'
        expect(multi_hash['two']).to eq 'number'
      end

      it 'modifying defined multi key (symbol)' do
        multi_hash[:a] = 'first_letter'

        expect(multi_hash[:a]).to eq 'first_letter'
        expect(multi_hash[:b]).to eq 'letter'
      end

      it 'modifying defined single key' do
        multi_hash['single'] = 'another_value'

        expect(multi_hash['single']).to eq 'another_value'
      end
    end

    context 'adds new keys to hash' do
      it 'adds single key value' do
        multi_hash[:new_single_key] = 'new_single_value'

        expect(multi_hash[:new_single_key]).to eq 'new_single_value'
      end

      it 'adds multi key value' do
        multi_hash[['c++', 'php', 'ruby', 'js']] = 'language'

        expect(multi_hash['c++']).to  eq 'language'
        expect(multi_hash['php']).to  eq 'language'
        expect(multi_hash['ruby']).to eq 'language'
        expect(multi_hash['js']).to   eq 'language'
      end
    end

    context 'deletes keys from hash' do
      it 'deletes single defined key' do
        multi_hash.delete('something')

        expect(multi_hash['something']).to eq nil
      end

      it 'deletes multi defined key' do
        multi_hash.delete(:a)

        expect(multi_hash[:a]).to eq nil
        expect(multi_hash[:b]).to eq 'letter'
        expect(multi_hash[:c]).to eq 'letter'
      end
    end

    context 'converts to regular hash' do
      it 'without multi keys' do
        regular_hash = multi_hash.to_h

        expect(regular_hash).to eq ({
          'one'    => 'number',
          'two'    => 'number',
          'three'  => 'number',
          :a 		   => 'letter',
          :b       => 'letter',
          :c       => 'letter',
          'single' => 'value'
        })
      end
    end
  end
end
