
abstract type Expression
end

struct NumberExp <: Expression
	value::Number
end

struct VariableExp <: Expression
	varname::String
end

struct AddExp <: Expression
	left_operand::Expression
	right_operand::Expression
end

struct SubtractExp <: Expression
	left_operand::Expression
	right_operand::Expression
end

struct Context
	variables::Dict{String, Number}
	Context(vars...) = new(Dict(vars))
end

lookup(ctx::Context, varname::AbstractString) = ctx.variables[varname]

function evaluate(exp::Expression, ctx::Context)
	error("Must implement evaluate")
end

function evaluate(exp::AddExp, ctx::Context)
	evaluate(exp.left_operand, ctx) + evaluate(exp.right_operand, ctx)
end

function evaluate(exp::SubtractExp, ctx::Context)
	evaluate(exp.left_operand, ctx) - evaluate(exp.right_operand, ctx)
end

evaluate(exp::NumberExp, ::Context) = exp.value

function evaluate(exp::VariableExp, ctx::Context)
	lookup(ctx, exp.varname)
end

alpha = VariableExp("alpha")
beta = VariableExp("beta")
ten = NumberExp(10.0)
sum = AddExp(alpha, beta)
exp = SubtractExp(sum, ten)

context = Context("alpha" => 5.0, "beta" => 5.0)
println(evaluate(exp, context))
