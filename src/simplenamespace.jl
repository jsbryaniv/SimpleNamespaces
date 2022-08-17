
"""
SimpleNamespaces creates SimpleNamespace objects.
SimpleNamespace is a dictionary wrapper that allows dot indexing.
For example:
    > x = SimpleNamespace(a=1, b=2)
    > x.c = "hello"
    > print(x.a, x.b, x.c)
    12hello 
"""

### SimpleNamespace ### 
struct SimpleNamespace
    properties::Dict{Symbol, Any}
    function SimpleNamespace(properties)
        self = new()
        self.properties = Dict{Symbol, Any}([(Symbol(key), val) for (key, val) in pairs(properties)])
    end
end
SimpleNamespace(;kwargs...) = SimpleNamespace(kwargs)

# Allow dot indexing to access properties
Base.getproperty(x::SimpleNamespace, property::Symbol) = getfield(x, :properties)[property]
Base.setproperty!(x::SimpleNamespace, property::Symbol, value) = getfield(x, :properties)[property] = value

# Allow property names and keys to be accessed using Base functions
Base.propertynames(x::SimpleNamespace) = keys(getfield(x, :properties))
Base.keys(x::SimpleNamespace) = keys(getfield(x, :properties))

# Allow property keys and values to be accessed using Base functions
Base.pairs(x::SimpleNamespace) = pairs(getfield(x, :properties))

# Allow for simple conversion to dictionary
Base.Dict(x::SimpleNamespace) = getfield(x, :properties)

# Define merge function
Base.merge(x::SimpleNamespace, others::SimpleNamespace...) = SimpleNamespace(merge(Dict(x), Dict.(others)...))

# Define copy functions
Base.copy(x::SimpleNamespace) = SimpleNamespace(copy(Dict(x)))
Base.deepcopy(x::SimpleNamespace) = SimpleNamespace(deepcopy(Dict(x)))



