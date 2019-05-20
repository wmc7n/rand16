return function(seed)

	local ins = {
		x = 0xD832,
		y = seed or 0x7645
	}

	ins.next = function(self)
		local t = bit.bxor(self.x, bit.lshift(self.x, 9))
		self.x = self.y
		self.y = bit.bxor(bit.bxor(self.y, bit.rshift(self.y, 5)), bit.bxor(t, bit.rshift(t, 14)))
		return self.y
	end

	ins.range = function(self, min, max)
		local a = math.abs(self:next())
		local b = max + 1 - min
		return min + a - math.floor(a/b)*b
	end

	ins.shuffle = function(self, ary)
		for i=1,#ary-1 do
			local k = #ary-i+1
			local r = self:range(1, k)
			local tmp = ary[k]
			ary[k] = ary[r]
			ary[r] = tmp
		end
		return ary
	end

	return ins

end