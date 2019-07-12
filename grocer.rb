def consolidate_cart(cart)
  newCart = {}
  cart.each do |itemHash|
    itemHash.each do |item, descriptionHash| 
      if newCart.include?(item) == false
        newCart[item] = descriptionHash
        newCart[item][:count] = 1
      else
        newCart[item][:count] += 1
      end
    end
  end
  return newCart
end

def apply_coupons(cart, coupons) 
  coupons.each do |couponHash| 
    item = couponHash[:item] 
    if cart[item] && cart[item][:count] >= couponHash[:num] 
      if cart[item + " W/COUPON"] 
        cart[item + " W/COUPON"][:count] += 1 
      else 
        couponHash[:cost]/couponHash[:num]
        cart["#{item} W/COUPON"] = {:price => couponHash[:cost], 
        :clearance => cart[item][:clearance], :count => 1} 
      end 
      cart[item][:count] -= couponHash[:num] 
    end 
  end 
  cart 
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
