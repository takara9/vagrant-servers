# -*- coding: iso-8859-1 -*-
#
# Cookbook Name:: ohai
# Recipe:: default
#
# mkdir -p /etc/chef/ohai/hints && touch ${_}/softlayer.json
#

def space(n)
  i = 1
  sp = ""
  while i < n
    sp = sp + "    "
    i = i + 1
  end
  return sp
end

def list_ohai(val,lv)
  lv = lv + 1
  sp = space(lv)
  val.each do |key, value|
    if value.kind_of?(Hash) then
      print sp , "[#{key}]\n"
      list_ohai(value,lv)
    end
    if value.kind_of?(String) || value.kind_of?(Array) then
      print sp, "[#{key}]= #{value}\n"
    end
  end
end


print "============================================\n"
list_ohai(node,0)
print "============================================\n"
