; ModuleID = '/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/server_reaction_function_0gt_linked.ll'
source_filename = "/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%struct.packet = type { i32, i32, i32 }

@.str = private unnamed_addr constant [49 x i8] c"(%lld, %d) [SERVER] Received packet id=%d seq=%d\00", align 1
@.str.1 = private unnamed_addr constant [22 x i8] c"[SERVER] Received SYN\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"[SERVER] Received ACK\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local [2 x i64] @_serverreaction_function_0(ptr noundef %0, i64 noundef %1, i32 noundef %2, [2 x i64] %3) #0 {
  %5 = alloca %struct.packet, align 4
  %6 = alloca %struct.packet, align 4
  %7 = alloca [2 x i64], align 8
  %8 = alloca ptr, align 8
  %9 = alloca i64, align 8
  %10 = alloca i32, align 4
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i8, align 1
  %14 = alloca [2 x i64], align 8
  store [2 x i64] %3, ptr %7, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %6, ptr align 8 %7, i64 12, i1 false)
  store ptr %0, ptr %8, align 8
  store i64 %1, ptr %9, align 8
  store i32 %2, ptr %10, align 4
  store ptr %6, ptr %11, align 8
  %15 = call noalias ptr @malloc(i64 noundef 12) #5
  store ptr %15, ptr %12, align 8
  %16 = load ptr, ptr %11, align 8
  %17 = getelementptr inbounds %struct.packet, ptr %16, i32 0, i32 0
  %18 = load i32, ptr %17, align 4
  %19 = load ptr, ptr %12, align 8
  %20 = getelementptr inbounds %struct.packet, ptr %19, i32 0, i32 0
  store i32 %18, ptr %20, align 4
  %21 = load ptr, ptr %11, align 8
  %22 = getelementptr inbounds %struct.packet, ptr %21, i32 0, i32 1
  %23 = load i32, ptr %22, align 4
  %24 = add nsw i32 %23, 1
  %25 = load ptr, ptr %12, align 8
  %26 = getelementptr inbounds %struct.packet, ptr %25, i32 0, i32 1
  store i32 %24, ptr %26, align 4
  store i8 1, ptr %13, align 1
  %27 = load i64, ptr %9, align 8
  %28 = load i32, ptr %10, align 4
  %29 = load ptr, ptr %11, align 8
  %30 = getelementptr inbounds %struct.packet, ptr %29, i32 0, i32 0
  %31 = load i32, ptr %30, align 4
  %32 = load ptr, ptr %11, align 8
  %33 = getelementptr inbounds %struct.packet, ptr %32, i32 0, i32 1
  %34 = load i32, ptr %33, align 4
  %35 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %27, i32 noundef %28, i32 noundef %31, i32 noundef %34)
  %36 = load ptr, ptr %11, align 8
  %37 = getelementptr inbounds %struct.packet, ptr %36, i32 0, i32 2
  %38 = load i32, ptr %37, align 4
  switch i32 %38, label %49 [
    i32 1, label %39
    i32 2, label %45
  ]

39:                                               ; preds = %4
  %40 = load i64, ptr %9, align 8
  %41 = load i32, ptr %10, align 4
  %42 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %40, i32 noundef %41)
  %43 = load ptr, ptr %12, align 8
  %44 = getelementptr inbounds %struct.packet, ptr %43, i32 0, i32 2
  store i32 3, ptr %44, align 4
  br label %49

45:                                               ; preds = %4
  %46 = load i64, ptr %9, align 8
  %47 = load i32, ptr %10, align 4
  %48 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i64 noundef %46, i32 noundef %47)
  store i8 0, ptr %13, align 1
  br label %49

49:                                               ; preds = %45, %39, %4
  call void @__gt_delay_for(i64 noundef 100000000)
  %50 = load i8, ptr %13, align 1
  %51 = trunc i8 %50 to i1
  br i1 %51, label %52, label %54

52:                                               ; preds = %49
  %53 = load ptr, ptr %12, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %5, ptr align 4 %53, i64 12, i1 false)
  br label %54

54:                                               ; preds = %52, %49
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %14, ptr align 4 %5, i64 12, i1 false)
  %55 = load [2 x i64], ptr %14, align 8
  ret [2 x i64] %55
}

; Function Attrs: alwaysinline nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: alwaysinline nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: alwaysinline
declare i32 @printf(ptr noundef, ...) #3

; Function Attrs: alwaysinline nounwind uwtable
define internal void @__gt_delay_for(i64 noundef %0) #4 {
  %2 = alloca i64, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  %5 = call i64 @__gt_get_rdtime()
  store i64 %5, ptr %3, align 8
  %6 = load i64, ptr %3, align 8
  %7 = load i64, ptr %2, align 8
  %8 = add i64 %6, %7
  store i64 %8, ptr %4, align 8
  br label %9

9:                                                ; preds = %13, %1
  %10 = call i64 @__gt_get_rdtime()
  %11 = load i64, ptr %4, align 8
  %12 = icmp ult i64 %10, %11
  br i1 %12, label %13, label %14

13:                                               ; preds = %9
  br label %9, !llvm.loop !6

14:                                               ; preds = %9
  ret void
}

; Function Attrs: alwaysinline nounwind uwtable
define internal i64 @__gt_get_rdtime() #4 {
  %1 = call i64 @read_time_hw()
  ret i64 %1
}

; Function Attrs: alwaysinline nounwind uwtable
define internal i64 @read_time_hw() #4 {
  %1 = alloca i64, align 8
  %2 = call i64 asm sideeffect "rdtime $0", "=r"() #6, !srcloc !8
  store i64 %2, ptr %1, align 8
  %3 = load i64, ptr %1, align 8
  ret i64 %3
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #1 = { alwaysinline nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { alwaysinline nounwind allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #3 = { alwaysinline "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #4 = { alwaysinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
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
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = !{i64 647}
