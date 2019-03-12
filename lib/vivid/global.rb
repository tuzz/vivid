def rgb(*args)
  PBRT::Builder.new.rgb(*args)
end

def xyz(*args)
  PBRT::Builder.new.xyz(*args)
end

def sampled(*args)
  PBRT::Builder.new.sampled(*args)
end

def blackbody(*args)
  PBRT::Builder.new.blackbody(*args)
end

def texture(*args)
  PBRT::Builder.new.texture(*args)
end
