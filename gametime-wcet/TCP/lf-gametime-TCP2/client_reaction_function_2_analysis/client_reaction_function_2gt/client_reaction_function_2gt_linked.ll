; ModuleID = '/home/gametime/test/lf-gametime-TCP2/client_reaction_function_2_analysis/client_reaction_function_2gt/client_reaction_function_2gt.bc'
source_filename = "/home/gametime/test/lf-gametime-TCP2/client_reaction_function_2_analysis/client_reaction_function_2.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%struct.packet = type { i32, i32, i32 }

@.str = private unnamed_addr constant [52 x i8] c"(%lld, %d) [CLIENT] Received packet (*id)=%d seq=%d\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"[CLIENT] Received SYN-ACK\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local [2 x i64] @_clientreaction_function_2(ptr noundef %0, ptr noundef %1, i64 noundef %2, i32 noundef %3, [2 x i64] %4) #0 {
  %6 = alloca %struct.packet, align 4
  %7 = alloca %struct.packet, align 4
  %8 = alloca [2 x i64], align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i64, align 8
  %12 = alloca i32, align 4
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca i8, align 1
  %16 = alloca [2 x i64], align 8
  store [2 x i64] %4, ptr %8, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %7, ptr align 8 %8, i64 12, i1 false)
  store ptr %0, ptr %9, align 8
  store ptr %1, ptr %10, align 8
  store i64 %2, ptr %11, align 8
  store i32 %3, ptr %12, align 4
  store ptr %7, ptr %13, align 8
  %17 = call noalias ptr @malloc(i64 noundef 12) #5
  store ptr %17, ptr %14, align 8
  %18 = load ptr, ptr %13, align 8
  %19 = getelementptr inbounds %struct.packet, ptr %18, i32 0, i32 0
  %20 = load i32, ptr %19, align 4
  %21 = load ptr, ptr %14, align 8
  %22 = getelementptr inbounds %struct.packet, ptr %21, i32 0, i32 0
  store i32 %20, ptr %22, align 4
  %23 = load ptr, ptr %13, align 8
  %24 = getelementptr inbounds %struct.packet, ptr %23, i32 0, i32 1
  %25 = load i32, ptr %24, align 4
  %26 = add nsw i32 %25, 1
  %27 = load ptr, ptr %14, align 8
  %28 = getelementptr inbounds %struct.packet, ptr %27, i32 0, i32 1
  store i32 %26, ptr %28, align 4
  store i8 1, ptr %15, align 1
  %29 = load i64, ptr %11, align 8
  %30 = load i32, ptr %12, align 4
  %31 = load ptr, ptr %13, align 8
  %32 = getelementptr inbounds %struct.packet, ptr %31, i32 0, i32 0
  %33 = load i32, ptr %32, align 4
  %34 = load ptr, ptr %13, align 8
  %35 = getelementptr inbounds %struct.packet, ptr %34, i32 0, i32 1
  %36 = load i32, ptr %35, align 4
  %37 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %29, i32 noundef %30, i32 noundef %33, i32 noundef %36)
  %38 = load ptr, ptr %13, align 8
  %39 = getelementptr inbounds %struct.packet, ptr %38, i32 0, i32 2
  %40 = load i32, ptr %39, align 4
  switch i32 %40, label %47 [
    i32 3, label %41
  ]

41:                                               ; preds = %5
  %42 = load i64, ptr %11, align 8
  %43 = load i32, ptr %12, align 4
  %44 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %42, i32 noundef %43)
  %45 = load ptr, ptr %14, align 8
  %46 = getelementptr inbounds %struct.packet, ptr %45, i32 0, i32 2
  store i32 2, ptr %46, align 4
  br label %47

47:                                               ; preds = %5, %41
  %48 = call i32 @randint(i32 noundef 40, i32 noundef 60)
  %49 = sext i32 %48 to i64
  %50 = mul nsw i64 %49, 1000000
  call void @__gt_delay_for(i64 noundef %50)
  %51 = load i8, ptr %15, align 1
  %52 = trunc i8 %51 to i1
  br i1 %52, label %53, label %55

53:                                               ; preds = %47
  %54 = load ptr, ptr %14, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %6, ptr align 4 %54, i64 12, i1 false)
  br label %55

55:                                               ; preds = %53, %47
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %16, ptr align 4 %6, i64 12, i1 false)
  %56 = load [2 x i64], ptr %16, align 8
  ret [2 x i64] %56
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

declare i32 @printf(ptr noundef, ...) #3

; Function Attrs: noinline nounwind uwtable
define internal void @__gt_delay_for(i64 noundef %0) #0 {
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

; Function Attrs: noinline nounwind uwtable
define internal i32 @randint(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = call i32 @rand() #6
  %6 = load i32, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = sub nsw i32 %6, %7
  %9 = add nsw i32 %8, 1
  %10 = srem i32 %5, %9
  %11 = load i32, ptr %3, align 4
  %12 = add nsw i32 %10, %11
  ret i32 %12
}

; Function Attrs: noinline nounwind uwtable
define internal i64 @__gt_get_rdtime() #0 {
  %1 = call i64 @read_time_hw()
  ret i64 %1
}

; Function Attrs: noinline nounwind uwtable
define internal i64 @read_time_hw() #0 {
  %1 = alloca i64, align 8
  %2 = call i64 asm sideeffect "rdtime $0", "=r"() #6, !srcloc !8
  store i64 %2, ptr %1, align 8
  %3 = load i64, ptr %1, align 8
  ret i64 %3
}

; Function Attrs: nounwind
declare i32 @rand() #4

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #3 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #4 = { nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
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
