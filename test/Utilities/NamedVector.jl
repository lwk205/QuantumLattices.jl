using Test
using Hamiltonian.Utilities.NamedVector

@namedvector true "FPID" (:scope,:site) Float64
@namedvector true "RPID" (:scope,:site) (<:Real)

@testset "FPID" begin
    @test FPID|>fieldnames==(:scope,:site)
    @test FPID|>length==2
    @test FPID|>eltype==Float64
    @test FPID|>zero==FPID(0.0,0.0)

    pid=FPID(1.0,0.0)
    @test pid|>string=="FPID(1.0,0.0)"
    @test pid|>length==2
    @test pid|>eltype==Float64
    @test pid|>zero==FPID(0.0,0.0)
    @test pid[1]==pid.scope==1.0
    @test pid[2]==pid.site==0.0
    @test replace(pid,scope=2.0)==FPID(2.0,0.0)
    @test replace(pid,site=1.0)==FPID(1.0,1.0)
    @test replace(pid,scope=2.0,site=1.0)==FPID(2.0,1.0)
    @test (pid[1]=2.0;pid[1]==2.0)
    @test (pid.site=3.0;pid.site==3.0)

    @test FPID(1.0,2.0)<FPID(2.0,0.0)
    @test FPID(1.0,2.0)<FPID(1.0,3.0)

    dict=Dict(FPID(0.0,0.0)=>1,FPID(0.0,1.0)=>2)
    @test dict[FPID(0.0,0.0)]==1
    @test dict[FPID(0.0,1.0)]==2
end

@testset "RPID" begin
    @test RPID|>fieldnames==(:scope,:site)
    @test RPID|>length==2
    @test RPID{Int}|>eltype==Int
    @test RPID{Int}|>zero==RPID(0,0)
    @test RPID{Float64}|>eltype==Float64
    @test RPID{Float64}|>zero==RPID(0.0,0.0)

    pid=RPID(1,0)
    @test pid|>string=="RPID(1,0)"
    @test pid|>length==2
    @test pid|>eltype==Int
    @test pid|>zero==RPID(0,0)
    @test pid[1]==pid.scope==1
    @test pid[2]==pid.site==0
    @test replace(pid,scope=2)==FPID(2,0)
    @test replace(pid,site=1)==FPID(1,1)
    @test replace(pid,scope=2,site=1)==FPID(2,1)
    @test (pid[1]=2;pid[1]==2)
    @test (pid.site=3;pid.site==3)

    @test RPID(1.0,2.0)<RPID(2.0,0.0)
    @test RPID(1.0,2.0)<RPID(1.0,3.0)

    dict=Dict(RPID(0,0)=>1,RPID(0,1)=>2)
    @test dict[RPID(0,0)]==1
    @test dict[RPID(0,1)]==2
end