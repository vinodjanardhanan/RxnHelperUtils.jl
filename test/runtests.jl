using RxnHelperUtils
using Test

@testset "RxnHelperUtils.jl" begin
    retcode = convert2si("cm")
    @test retcode == 0.01

    retcode = get_index("CH4",["CH4", "CO2"])
    @test retcode == 1
end
