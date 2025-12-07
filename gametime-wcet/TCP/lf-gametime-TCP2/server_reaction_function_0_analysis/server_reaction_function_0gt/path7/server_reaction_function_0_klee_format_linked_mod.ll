; ModuleID = '/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/path7/server_reaction_function_0_klee_format_linked.ll'
source_filename = "/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/path7/server_reaction_function_0_klee_format.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%struct.packet = type { i32, i32, i32 }

@conditional_var_0 = dso_local global i8 0, align 1
@conditional_var_1 = dso_local global i8 0, align 1
@conditional_var_2 = dso_local global i8 0, align 1
@conditional_var_3 = dso_local global i8 0, align 1
@conditional_var_4 = dso_local global i8 0, align 1
@conditional_var_5 = dso_local global i8 0, align 1
@conditional_var_6 = dso_local global i8 1, align 1
@conditional_var_7 = dso_local global i8 1, align 1
@.str = private unnamed_addr constant [49 x i8] c"(%lld, %d) [SERVER] Received packet id=%d seq=%d\00", align 1
@.str.1 = private unnamed_addr constant [22 x i8] c"[SERVER] Received SYN\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"[SERVER] Received ACK\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"refresh_val\00", align 1
@.str.4 = private unnamed_addr constant [24 x i8] c"__symbolic_elapsed_time\00", align 1
@.str.5 = private unnamed_addr constant [21 x i8] c"__symbolic_microstep\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"inp\00", align 1
@.str.7 = private unnamed_addr constant [18 x i8] c"conditional_var_0\00", align 1
@.str.8 = private unnamed_addr constant [149 x i8] c"/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/path7/server_reaction_function_0_klee_format.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str.9 = private unnamed_addr constant [18 x i8] c"conditional_var_1\00", align 1
@.str.10 = private unnamed_addr constant [18 x i8] c"conditional_var_2\00", align 1
@.str.11 = private unnamed_addr constant [18 x i8] c"conditional_var_3\00", align 1
@.str.12 = private unnamed_addr constant [18 x i8] c"conditional_var_4\00", align 1
@.str.13 = private unnamed_addr constant [18 x i8] c"conditional_var_5\00", align 1
@.str.14 = private unnamed_addr constant [18 x i8] c"conditional_var_6\00", align 1
@.str.15 = private unnamed_addr constant [18 x i8] c"conditional_var_7\00", align 1

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
define dso_local i32 @main() #4 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca %struct.packet, align 4
  %7 = alloca [2 x i64], align 8
  %8 = alloca %struct.packet, align 4
  %9 = alloca [2 x i64], align 8
  store i32 0, ptr %1, align 4
  call void @klee_make_symbolic(ptr noundef %2, i64 noundef 8, ptr noundef @.str.3)
  store ptr %2, ptr %3, align 8
  call void @klee_make_symbolic(ptr noundef %4, i64 noundef 8, ptr noundef @.str.4)
  call void @klee_make_symbolic(ptr noundef %5, i64 noundef 4, ptr noundef @.str.5)
  call void @klee_make_symbolic(ptr noundef %6, i64 noundef 12, ptr noundef @.str.6)
  %10 = getelementptr inbounds %struct.packet, ptr %6, i32 0, i32 2
  %11 = load i32, ptr %10, align 4
  %12 = icmp eq i32 %11, 2
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  call void @klee_assume(i64 noundef %14)
  %15 = load ptr, ptr %3, align 8
  %16 = load i64, ptr %4, align 8
  %17 = load i32, ptr %5, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %7, ptr align 4 %6, i64 12, i1 false)
  %18 = load [2 x i64], ptr %7, align 8
  %19 = call [2 x i64] @_serverreaction_function_0(ptr noundef %15, i64 noundef %16, i32 noundef %17, [2 x i64] %18)
  store [2 x i64] %19, ptr %9, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %8, ptr align 8 %9, i64 12, i1 false)
  %20 = load i8, ptr @conditional_var_0, align 1
  %21 = trunc i8 %20 to i1
  br i1 %21, label %22, label %23

22:                                               ; preds = %0
  br label %25

23:                                               ; preds = %0
  %24 = call i32 @__assert_fail(ptr noundef @.str.7, ptr noundef @.str.8, i32 noundef 113, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %25

25:                                               ; preds = %23, %22
  %26 = load i8, ptr @conditional_var_1, align 1
  %27 = trunc i8 %26 to i1
  br i1 %27, label %28, label %29

28:                                               ; preds = %25
  br label %31

29:                                               ; preds = %25
  %30 = call i32 @__assert_fail(ptr noundef @.str.9, ptr noundef @.str.8, i32 noundef 114, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %31

31:                                               ; preds = %29, %28
  %32 = load i8, ptr @conditional_var_2, align 1
  %33 = trunc i8 %32 to i1
  br i1 %33, label %34, label %35

34:                                               ; preds = %31
  br label %37

35:                                               ; preds = %31
  %36 = call i32 @__assert_fail(ptr noundef @.str.10, ptr noundef @.str.8, i32 noundef 115, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %37

37:                                               ; preds = %35, %34
  %38 = load i8, ptr @conditional_var_3, align 1
  %39 = trunc i8 %38 to i1
  br i1 %39, label %40, label %41

40:                                               ; preds = %37
  br label %43

41:                                               ; preds = %37
  %42 = call i32 @__assert_fail(ptr noundef @.str.11, ptr noundef @.str.8, i32 noundef 116, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %43

43:                                               ; preds = %41, %40
  %44 = load i8, ptr @conditional_var_4, align 1
  %45 = trunc i8 %44 to i1
  br i1 %45, label %46, label %47

46:                                               ; preds = %43
  br label %49

47:                                               ; preds = %43
  %48 = call i32 @__assert_fail(ptr noundef @.str.12, ptr noundef @.str.8, i32 noundef 117, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %49

49:                                               ; preds = %47, %46
  %50 = load i8, ptr @conditional_var_5, align 1
  %51 = trunc i8 %50 to i1
  br i1 %51, label %52, label %53

52:                                               ; preds = %49
  br label %55

53:                                               ; preds = %49
  %54 = call i32 @__assert_fail(ptr noundef @.str.13, ptr noundef @.str.8, i32 noundef 118, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %55

55:                                               ; preds = %53, %52
  %56 = load i8, ptr @conditional_var_6, align 1
  %57 = trunc i8 %56 to i1
  br i1 %57, label %58, label %59

58:                                               ; preds = %55
  br label %61

59:                                               ; preds = %55
  %60 = call i32 @__assert_fail(ptr noundef @.str.14, ptr noundef @.str.8, i32 noundef 119, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %61

61:                                               ; preds = %59, %58
  %62 = load i8, ptr @conditional_var_7, align 1
  %63 = trunc i8 %62 to i1
  br i1 %63, label %64, label %65

64:                                               ; preds = %61
  br label %67

65:                                               ; preds = %61
  %66 = call i32 @__assert_fail(ptr noundef @.str.15, ptr noundef @.str.8, i32 noundef 120, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %67

67:                                               ; preds = %65, %64
  ret i32 0
}

; Function Attrs: alwaysinline
declare void @klee_make_symbolic(ptr noundef, i64 noundef, ptr noundef) #3

; Function Attrs: alwaysinline
declare void @klee_assume(i64 noundef) #3

; Function Attrs: alwaysinline
declare i32 @__assert_fail(...) #3

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
!8 = !{i64 985}
