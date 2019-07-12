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
    if cart.include?(item) && cart[item][:count] >= couponHash[:num] 
      if cart.include?(item + " W/COUPON")
        cart[item + " W/COUPON"][:count] += couponHash[:num] 
      else 
        cart[item + " W/COUPON"] = {:price => (couponHash[:cost]/couponHash[:num]), 
        :clearance => cart[item][:clearance], :count => couponHash[:num]} 
      end 
      cart[item][:count] -= couponHash[:num] 
    end 
  end 
  cart 
end

def apply_clearance(cart)
  cart.each do |item, price_hash|
    if price_hash[:clearance] == true
      price_hash[:price] = (price_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(items, coupons)
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)
  
  total = 0
  
  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end
  if total > 100 
    return total * 0.9
  else 
    return total 
  end
end
