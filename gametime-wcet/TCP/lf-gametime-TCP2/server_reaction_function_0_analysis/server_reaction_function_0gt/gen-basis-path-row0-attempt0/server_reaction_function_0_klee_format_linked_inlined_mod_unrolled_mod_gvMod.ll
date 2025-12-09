; ModuleID = '/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/gen-basis-path-row0-attempt0/server_reaction_function_0_klee_format_linked_inlined_mod_unrolled_mod.bc'
source_filename = "/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/gen-basis-path-row0-attempt0/server_reaction_function_0_klee_format.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%struct.packet = type { i32, i32, i32 }

@conditional_var_0 = dso_local global i8 0, align 1
@conditional_var_1 = dso_local global i8 0, align 1
@conditional_var_2 = dso_local global i8 0, align 1
@conditional_var_3 = dso_local global i8 0, align 1
@conditional_var_4 = dso_local global i8 0, align 1
@conditional_var_5 = dso_local global i8 1, align 1
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
@.str.8 = private unnamed_addr constant [172 x i8] c"/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/gen-basis-path-row0-attempt0/server_reaction_function_0_klee_format.c\00", align 1
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
  store i8 1, ptr @conditional_var_0, align 1
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
  %20 = call noalias ptr @malloc(i64 noundef 12) #6
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
  store i8 0, ptr @conditional_var_5, align 1
  %45 = load i64, ptr %14, align 8
  %46 = load i32, ptr %15, align 4
  %47 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %45, i32 noundef %46)
  %48 = load ptr, ptr %17, align 8
  %49 = getelementptr inbounds %struct.packet, ptr %48, i32 0, i32 2
  store i32 3, ptr %49, align 4
  br label %54

50:                                               ; preds = %4
  store i8 0, ptr @conditional_var_6, align 1
  %51 = load i64, ptr %14, align 8
  %52 = load i32, ptr %15, align 4
  %53 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i64 noundef %51, i32 noundef %52)
  store i8 0, ptr %18, align 1
  br label %54

54:                                               ; preds = %50, %44, %4
  store i8 1, ptr @conditional_var_1, align 1
  call void @llvm.lifetime.start.p0(i64 8, ptr %7)
  call void @llvm.lifetime.start.p0(i64 8, ptr %8)
  call void @llvm.lifetime.start.p0(i64 8, ptr %9)
  store i64 100000000, ptr %7, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr %6)
  %55 = call i64 asm sideeffect "rdtime $0", "=r"() #7, !srcloc !6
  store i64 %55, ptr %6, align 8
  %56 = load i64, ptr %6, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr %6)
  store i64 %56, ptr %8, align 8
  %57 = load i64, ptr %8, align 8
  %58 = load i64, ptr %7, align 8
  %59 = add i64 %57, %58
  store i64 %59, ptr %9, align 8
  br label %60

60:                                               ; preds = %54
  store i8 1, ptr @conditional_var_2, align 1
  call void @llvm.lifetime.start.p0(i64 8, ptr %5)
  %61 = call i64 asm sideeffect "rdtime $0", "=r"() #7, !srcloc !6
  store i64 %61, ptr %5, align 8
  %62 = load i64, ptr %5, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr %5)
  %63 = load i64, ptr %9, align 8
  %64 = icmp ult i64 %62, %63
  br i1 %64, label %65, label %__gt_delay_for.exit

65:                                               ; preds = %60
  store i8 0, ptr @conditional_var_7, align 1
  br label %68, !llvm.loop !7

__gt_delay_for.exit:                              ; preds = %60
  call void @llvm.lifetime.end.p0(i64 8, ptr %7)
  call void @llvm.lifetime.end.p0(i64 8, ptr %8)
  call void @llvm.lifetime.end.p0(i64 8, ptr %9)
  %66 = load i8, ptr %18, align 1
  %67 = trunc i8 %66 to i1
  br i1 %67, label %68, label %70

68:                                               ; preds = %__gt_delay_for.exit, %65
  store i8 1, ptr @conditional_var_3, align 1
  %69 = load ptr, ptr %17, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %10, ptr align 4 %69, i64 12, i1 false)
  br label %70

70:                                               ; preds = %68, %__gt_delay_for.exit
  store i8 1, ptr @conditional_var_4, align 1
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
  %12 = icmp eq i32 %11, 1
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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #5

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { alwaysinline nounwind allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #3 = { alwaysinline "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #4 = { alwaysinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
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
!6 = !{i64 984}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
