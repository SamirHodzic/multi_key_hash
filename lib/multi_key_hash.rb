require 'multi_key_hash/version'
require 'digest'

class MultiKeyHash
	def initialize(values = nil)
		@next_key = 1
		@outer = @inner = {}
		order_values(values)
	end

	def [](outer_key)
		@outer[outer_key].nil? ? nil : @inner[@outer[outer_key]]
	end

	def []=(outer_key, new_value)
		if outer_key.is_a?(Array) && !outer_key.empty?
			order_values(outer_key, new_value)
		else
			inner_key = @inner.select do |_, existing|
				existing == new_value
			end.map do |key, _|
				key
			end.first

			if inner_key
				@outer[outer_key] = inner_key
			else
				remove_hex_key(outer_key)
				uniq_key = generate_uniq
				@outer[outer_key] = uniq_key
				@inner[uniq_key] = new_value
				@next_key += 1
			end
		end
  end

	def to_h
		converted = {}
		@inner.each do |i_key, i_value|
			@outer.each do |o_key, o_value|
				if i_value == o_key
					converted[i_key] = o_value
				end
			end
		end

		converted
  end

	def delete(key)
		remove_hex_key(key)
		delete_key(key)
	end

	private

	def order_values(values, ar = nil)
		values&.each do |keys, value|
			if keys.is_a?(Array) && !keys.empty?
				keys.each do |key|
					self[key] = value
				end
			else
				self[keys] = ar || value
			end
		end
	end

	def remove_hex_key(outer_key)
		check_key = @outer[outer_key]

		if multiple_presence(check_key) == 1
			delete_key(check_key)
		end
	end

	def multiple_presence(key)
		@outer.count do |el|
			el[1] == key
		end
	end

	def delete_key(key)
		@outer.delete(key)
		@inner.delete(key)
	end

	def generate_uniq
		Digest::SHA1.hexdigest(@next_key.to_s)[8..16]
	end
end
