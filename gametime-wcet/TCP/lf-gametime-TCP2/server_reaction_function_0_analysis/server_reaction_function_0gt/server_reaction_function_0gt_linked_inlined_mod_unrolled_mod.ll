; ModuleID = '/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/server_reaction_function_0gt_linked_inlined_mod.ll'
source_filename = "/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%struct.packet = type { i32, i32, i32 }

@.str = private unnamed_addr constant [49 x i8] c"(%lld, %d) [SERVER] Received packet id=%d seq=%d\00", align 1
@.str.1 = private unnamed_addr constant [22 x i8] c"[SERVER] Received SYN\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"[SERVER] Received ACK\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local [2 x i64] @_serverreaction_function_0(ptr noundef %0, i64 noundef %1, i32 noundef %2, [2 x i64] %3) #0 {
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca %struct.packet, align 4
  %11 = alloca %struct.packet, align 4
  %12 = alloca [2 x i64], align 8
  %13 = alloca ptr, align 8
  %14 = alloca i64, align 8
  %15 = alloca i32, align 4
  %16 = alloca ptr, align 8
  %17 = alloca ptr, align 8
  %18 = alloca i8, align 1
  %19 = alloca [2 x i64], align 8
  store [2 x i64] %3, ptr %12, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %11, ptr align 8 %12, i64 12, i1 false)
  store ptr %0, ptr %13, align 8
  store i64 %1, ptr %14, align 8
  store i32 %2, ptr %15, align 4
  store ptr %11, ptr %16, align 8
  %20 = call noalias ptr @malloc(i64 noundef 12) #5
  store ptr %20, ptr %17, align 8
  %21 = load ptr, ptr %16, align 8
  %22 = getelementptr inbounds %struct.packet, ptr %21, i32 0, i32 0
  %23 = load i32, ptr %22, align 4
  %24 = load ptr, ptr %17, align 8
  %25 = getelementptr inbounds %struct.packet, ptr %24, i32 0, i32 0
  store i32 %23, ptr %25, align 4
  %26 = load ptr, ptr %16, align 8
  %27 = getelementptr inbounds %struct.packet, ptr %26, i32 0, i32 1
  %28 = load i32, ptr %27, align 4
  %29 = add nsw i32 %28, 1
  %30 = load ptr, ptr %17, align 8
  %31 = getelementptr inbounds %struct.packet, ptr %30, i32 0, i32 1
  store i32 %29, ptr %31, align 4
  store i8 1, ptr %18, align 1
  %32 = load i64, ptr %14, align 8
  %33 = load i32, ptr %15, align 4
  %34 = load ptr, ptr %16, align 8
  %35 = getelementptr inbounds %struct.packet, ptr %34, i32 0, i32 0
  %36 = load i32, ptr %35, align 4
  %37 = load ptr, ptr %16, align 8
  %38 = getelementptr inbounds %struct.packet, ptr %37, i32 0, i32 1
  %39 = load i32, ptr %38, align 4
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %32, i32 noundef %33, i32 noundef %36, i32 noundef %39)
  %41 = load ptr, ptr %16, align 8
  %42 = getelementptr inbounds %struct.packet, ptr %41, i32 0, i32 2
  %43 = load i32, ptr %42, align 4
  switch i32 %43, label %54 [
    i32 1, label %44
    i32 2, label %50
  ]

44:                                               ; preds = %4
  %45 = load i64, ptr %14, align 8
  %46 = load i32, ptr %15, align 4
  %47 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %45, i32 noundef %46)
  %48 = load ptr, ptr %17, align 8
  %49 = getelementptr inbounds %struct.packet, ptr %48, i32 0, i32 2
  store i32 3, ptr %49, align 4
  br label %54

50:                                               ; preds = %4
  %51 = load i64, ptr %14, align 8
  %52 = load i32, ptr %15, align 4
  %53 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i64 noundef %51, i32 noundef %52)
  store i8 0, ptr %18, align 1
  br label %54

54:                                               ; preds = %50, %44, %4
  call void @llvm.lifetime.start.p0(i64 8, ptr %7)
  call void @llvm.lifetime.start.p0(i64 8, ptr %8)
  call void @llvm.lifetime.start.p0(i64 8, ptr %9)
  store i64 100000000, ptr %7, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr %6)
  %55 = call i64 asm sideeffect "rdtime $0", "=r"() #6, !srcloc !6
  store i64 %55, ptr %6, align 8
  %56 = load i64, ptr %6, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr %6)
  store i64 %56, ptr %8, align 8
  %57 = load i64, ptr %8, align 8
  %58 = load i64, ptr %7, align 8
  %59 = add i64 %57, %58
  store i64 %59, ptr %9, align 8
  br label %60

60:                                               ; preds = %65, %54
  call void @llvm.lifetime.start.p0(i64 8, ptr %5)
  %61 = call i64 asm sideeffect "rdtime $0", "=r"() #6, !srcloc !6
  store i64 %61, ptr %5, align 8
  %62 = load i64, ptr %5, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr %5)
  %63 = load i64, ptr %9, align 8
  %64 = icmp ult i64 %62, %63
  br i1 %64, label %65, label %__gt_delay_for.exit

65:                                               ; preds = %60
  br label %68, !llvm.loop !7

__gt_delay_for.exit:                              ; preds = %60
  call void @llvm.lifetime.end.p0(i64 8, ptr %7)
  call void @llvm.lifetime.end.p0(i64 8, ptr %8)
  call void @llvm.lifetime.end.p0(i64 8, ptr %9)
  %66 = load i8, ptr %18, align 1
  %67 = trunc i8 %66 to i1
  br i1 %67, label %68, label %70

68:                                               ; preds = %__gt_delay_for.exit
  %69 = load ptr, ptr %17, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %10, ptr align 4 %69, i64 12, i1 false)
  br label %70

70:                                               ; preds = %68, %__gt_delay_for.exit
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %19, ptr align 4 %10, i64 12, i1 false)
  %71 = load [2 x i64], ptr %19, align 8
  ret [2 x i64] %71
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: alwaysinline nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: alwaysinline
declare i32 @printf(ptr noundef, ...) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #4

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { alwaysinline nounwind allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #3 = { alwaysinline "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { nounwind allocsize(0) }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
!6 = !{i64 647}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}