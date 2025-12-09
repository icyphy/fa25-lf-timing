; ModuleID = '/home/gametime/test/lf-gametime-TCP2/client_reaction_function_2_analysis/client_reaction_function_2gt/client_reaction_function_2gt_linked_inlined_mod.bc'
source_filename = "/home/gametime/test/lf-gametime-TCP2/client_reaction_function_2_analysis/client_reaction_function_2.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%struct.packet = type { i32, i32, i32 }

@.str = private unnamed_addr constant [52 x i8] c"(%lld, %d) [CLIENT] Received packet (*id)=%d seq=%d\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"[CLIENT] Received SYN-ACK\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local [2 x i64] @_clientreaction_function_2(ptr noundef %0, ptr noundef %1, i64 noundef %2, i32 noundef %3, [2 x i64] %4) #0 {
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i64, align 8
  %13 = alloca %struct.packet, align 4
  %14 = alloca %struct.packet, align 4
  %15 = alloca [2 x i64], align 8
  %16 = alloca ptr, align 8
  %17 = alloca ptr, align 8
  %18 = alloca i64, align 8
  %19 = alloca i32, align 4
  %20 = alloca ptr, align 8
  %21 = alloca ptr, align 8
  %22 = alloca i8, align 1
  %23 = alloca [2 x i64], align 8
  store [2 x i64] %4, ptr %15, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %14, ptr align 8 %15, i64 12, i1 false)
  store ptr %0, ptr %16, align 8
  store ptr %1, ptr %17, align 8
  store i64 %2, ptr %18, align 8
  store i32 %3, ptr %19, align 4
  store ptr %14, ptr %20, align 8
  %24 = call noalias ptr @malloc(i64 noundef 12) #6
  store ptr %24, ptr %21, align 8
  %25 = load ptr, ptr %20, align 8
  %26 = getelementptr inbounds %struct.packet, ptr %25, i32 0, i32 0
  %27 = load i32, ptr %26, align 4
  %28 = load ptr, ptr %21, align 8
  %29 = getelementptr inbounds %struct.packet, ptr %28, i32 0, i32 0
  store i32 %27, ptr %29, align 4
  %30 = load ptr, ptr %20, align 8
  %31 = getelementptr inbounds %struct.packet, ptr %30, i32 0, i32 1
  %32 = load i32, ptr %31, align 4
  %33 = add nsw i32 %32, 1
  %34 = load ptr, ptr %21, align 8
  %35 = getelementptr inbounds %struct.packet, ptr %34, i32 0, i32 1
  store i32 %33, ptr %35, align 4
  store i8 1, ptr %22, align 1
  %36 = load i64, ptr %18, align 8
  %37 = load i32, ptr %19, align 4
  %38 = load ptr, ptr %20, align 8
  %39 = getelementptr inbounds %struct.packet, ptr %38, i32 0, i32 0
  %40 = load i32, ptr %39, align 4
  %41 = load ptr, ptr %20, align 8
  %42 = getelementptr inbounds %struct.packet, ptr %41, i32 0, i32 1
  %43 = load i32, ptr %42, align 4
  %44 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %36, i32 noundef %37, i32 noundef %40, i32 noundef %43)
  %45 = load ptr, ptr %20, align 8
  %46 = getelementptr inbounds %struct.packet, ptr %45, i32 0, i32 2
  %47 = load i32, ptr %46, align 4
  switch i32 %47, label %54 [
    i32 3, label %48
  ]

48:                                               ; preds = %5
  %49 = load i64, ptr %18, align 8
  %50 = load i32, ptr %19, align 4
  %51 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %49, i32 noundef %50)
  %52 = load ptr, ptr %21, align 8
  %53 = getelementptr inbounds %struct.packet, ptr %52, i32 0, i32 2
  store i32 2, ptr %53, align 4
  br label %54

54:                                               ; preds = %48, %5
  call void @llvm.lifetime.start.p0(i64 4, ptr %8)
  call void @llvm.lifetime.start.p0(i64 4, ptr %9)
  store i32 40, ptr %8, align 4
  store i32 60, ptr %9, align 4
  %55 = call i32 @rand() #7
  %56 = load i32, ptr %9, align 4
  %57 = load i32, ptr %8, align 4
  %58 = sub nsw i32 %56, %57
  %59 = add nsw i32 %58, 1
  %60 = srem i32 %55, %59
  %61 = load i32, ptr %8, align 4
  %62 = add nsw i32 %60, %61
  call void @llvm.lifetime.end.p0(i64 4, ptr %8)
  call void @llvm.lifetime.end.p0(i64 4, ptr %9)
  %63 = sext i32 %62 to i64
  %64 = mul nsw i64 %63, 1000000
  call void @llvm.lifetime.start.p0(i64 8, ptr %10)
  call void @llvm.lifetime.start.p0(i64 8, ptr %11)
  call void @llvm.lifetime.start.p0(i64 8, ptr %12)
  store i64 %64, ptr %10, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr %7)
  %65 = call i64 asm sideeffect "rdtime $0", "=r"() #7, !srcloc !6
  store i64 %65, ptr %7, align 8
  %66 = load i64, ptr %7, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr %7)
  store i64 %66, ptr %11, align 8
  %67 = load i64, ptr %11, align 8
  %68 = load i64, ptr %10, align 8
  %69 = add i64 %67, %68
  store i64 %69, ptr %12, align 8
  br label %70

70:                                               ; preds = %75, %54
  call void @llvm.lifetime.start.p0(i64 8, ptr %6)
  %71 = call i64 asm sideeffect "rdtime $0", "=r"() #7, !srcloc !6
  store i64 %71, ptr %6, align 8
  %72 = load i64, ptr %6, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr %6)
  %73 = load i64, ptr %12, align 8
  %74 = icmp ult i64 %72, %73
  br i1 %74, label %75, label %__gt_delay_for.exit

75:                                               ; preds = %70
  br label %70, !llvm.loop !7

__gt_delay_for.exit:                              ; preds = %70
  call void @llvm.lifetime.end.p0(i64 8, ptr %10)
  call void @llvm.lifetime.end.p0(i64 8, ptr %11)
  call void @llvm.lifetime.end.p0(i64 8, ptr %12)
  %76 = load i8, ptr %22, align 1
  %77 = trunc i8 %76 to i1
  br i1 %77, label %78, label %80

78:                                               ; preds = %__gt_delay_for.exit
  %79 = load ptr, ptr %21, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %13, ptr align 4 %79, i64 12, i1 false)
  br label %80

80:                                               ; preds = %78, %__gt_delay_for.exit
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %23, ptr align 4 %13, i64 12, i1 false)
  %81 = load [2 x i64], ptr %23, align 8
  ret [2 x i64] %81
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: alwaysinline nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: alwaysinline
declare i32 @printf(ptr noundef, ...) #3

; Function Attrs: alwaysinline nounwind
declare i32 @rand() #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #5

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { alwaysinline nounwind allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #3 = { alwaysinline "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #4 = { alwaysinline nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #6 = { nounwind allocsize(0) }
attributes #7 = { nounwind }

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
