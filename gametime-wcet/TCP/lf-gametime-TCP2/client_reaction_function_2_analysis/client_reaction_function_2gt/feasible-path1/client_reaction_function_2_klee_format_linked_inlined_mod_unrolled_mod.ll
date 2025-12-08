; ModuleID = '/home/gametime/test/lf-gametime-TCP2/client_reaction_function_2_analysis/client_reaction_function_2gt/feasible-path1/client_reaction_function_2_klee_format_linked_inlined_mod_unrolled_mod.bc'
source_filename = "/home/gametime/test/lf-gametime-TCP2/client_reaction_function_2_analysis/client_reaction_function_2gt/feasible-path1/client_reaction_function_2_klee_format.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

%struct.packet = type { i32, i32, i32 }

@conditional_var_0 = dso_local global i8 0, align 1
@conditional_var_1 = dso_local global i8 0, align 1
@conditional_var_2 = dso_local global i8 0, align 1
@conditional_var_3 = dso_local global i8 0, align 1
@conditional_var_4 = dso_local global i8 0, align 1
@conditional_var_5 = dso_local global i8 0, align 1
@conditional_var_6 = dso_local global i8 0, align 1
@.str = private unnamed_addr constant [52 x i8] c"(%lld, %d) [CLIENT] Received packet (*id)=%d seq=%d\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"[CLIENT] Received SYN-ACK\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"period_val\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"id_val\00", align 1
@.str.4 = private unnamed_addr constant [24 x i8] c"__symbolic_elapsed_time\00", align 1
@.str.5 = private unnamed_addr constant [21 x i8] c"__symbolic_microstep\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"inp\00", align 1
@.str.7 = private unnamed_addr constant [18 x i8] c"conditional_var_0\00", align 1
@.str.8 = private unnamed_addr constant [158 x i8] c"/home/gametime/test/lf-gametime-TCP2/client_reaction_function_2_analysis/client_reaction_function_2gt/feasible-path1/client_reaction_function_2_klee_format.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str.9 = private unnamed_addr constant [18 x i8] c"conditional_var_1\00", align 1
@.str.10 = private unnamed_addr constant [18 x i8] c"conditional_var_2\00", align 1
@.str.11 = private unnamed_addr constant [18 x i8] c"conditional_var_3\00", align 1
@.str.12 = private unnamed_addr constant [18 x i8] c"conditional_var_4\00", align 1
@.str.13 = private unnamed_addr constant [18 x i8] c"conditional_var_5\00", align 1
@.str.14 = private unnamed_addr constant [18 x i8] c"conditional_var_6\00", align 1

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
  %24 = call noalias ptr @malloc(i64 noundef 12) #7
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
  %55 = call i32 @rand() #8
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
  %65 = call i64 asm sideeffect "rdtime $0", "=r"() #8, !srcloc !6
  store i64 %65, ptr %7, align 8
  %66 = load i64, ptr %7, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr %7)
  store i64 %66, ptr %11, align 8
  %67 = load i64, ptr %11, align 8
  %68 = load i64, ptr %10, align 8
  %69 = add i64 %67, %68
  store i64 %69, ptr %12, align 8
  br label %70

70:                                               ; preds = %54
  call void @llvm.lifetime.start.p0(i64 8, ptr %6)
  %71 = call i64 asm sideeffect "rdtime $0", "=r"() #8, !srcloc !6
  store i64 %71, ptr %6, align 8
  %72 = load i64, ptr %6, align 8
  call void @llvm.lifetime.end.p0(i64 8, ptr %6)
  %73 = load i64, ptr %12, align 8
  %74 = icmp ult i64 %72, %73
  br i1 %74, label %75, label %__gt_delay_for.exit

75:                                               ; preds = %70
  br label %78, !llvm.loop !7

__gt_delay_for.exit:                              ; preds = %70
  call void @llvm.lifetime.end.p0(i64 8, ptr %10)
  call void @llvm.lifetime.end.p0(i64 8, ptr %11)
  call void @llvm.lifetime.end.p0(i64 8, ptr %12)
  %76 = load i8, ptr %22, align 1
  %77 = trunc i8 %76 to i1
  br i1 %77, label %78, label %80

78:                                               ; preds = %__gt_delay_for.exit, %75
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

; Function Attrs: alwaysinline nounwind uwtable
define dso_local i32 @main() #4 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.packet, align 4
  %9 = alloca [2 x i64], align 8
  %10 = alloca %struct.packet, align 4
  %11 = alloca [2 x i64], align 8
  store i32 0, ptr %1, align 4
  call void @klee_make_symbolic(ptr noundef %2, i64 noundef 8, ptr noundef @.str.2)
  store ptr %2, ptr %3, align 8
  call void @klee_make_symbolic(ptr noundef %4, i64 noundef 4, ptr noundef @.str.3)
  store ptr %4, ptr %5, align 8
  call void @klee_make_symbolic(ptr noundef %6, i64 noundef 8, ptr noundef @.str.4)
  call void @klee_make_symbolic(ptr noundef %7, i64 noundef 4, ptr noundef @.str.5)
  call void @klee_make_symbolic(ptr noundef %8, i64 noundef 12, ptr noundef @.str.6)
  %12 = getelementptr inbounds %struct.packet, ptr %8, i32 0, i32 2
  %13 = load i32, ptr %12, align 4
  %14 = icmp eq i32 %13, 3
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  call void @klee_assume(i64 noundef %16)
  %17 = load ptr, ptr %3, align 8
  %18 = load ptr, ptr %5, align 8
  %19 = load i64, ptr %6, align 8
  %20 = load i32, ptr %7, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %9, ptr align 4 %8, i64 12, i1 false)
  %21 = load [2 x i64], ptr %9, align 8
  %22 = call [2 x i64] @_clientreaction_function_2(ptr noundef %17, ptr noundef %18, i64 noundef %19, i32 noundef %20, [2 x i64] %21)
  store [2 x i64] %22, ptr %11, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %10, ptr align 8 %11, i64 12, i1 false)
  %23 = load i8, ptr @conditional_var_0, align 1
  %24 = trunc i8 %23 to i1
  br i1 %24, label %25, label %26

25:                                               ; preds = %0
  br label %28

26:                                               ; preds = %0
  %27 = call i32 @__assert_fail(ptr noundef @.str.7, ptr noundef @.str.8, i32 noundef 111, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %28

28:                                               ; preds = %26, %25
  %29 = load i8, ptr @conditional_var_1, align 1
  %30 = trunc i8 %29 to i1
  br i1 %30, label %31, label %32

31:                                               ; preds = %28
  br label %34

32:                                               ; preds = %28
  %33 = call i32 @__assert_fail(ptr noundef @.str.9, ptr noundef @.str.8, i32 noundef 112, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %34

34:                                               ; preds = %32, %31
  %35 = load i8, ptr @conditional_var_2, align 1
  %36 = trunc i8 %35 to i1
  br i1 %36, label %37, label %38

37:                                               ; preds = %34
  br label %40

38:                                               ; preds = %34
  %39 = call i32 @__assert_fail(ptr noundef @.str.10, ptr noundef @.str.8, i32 noundef 113, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %40

40:                                               ; preds = %38, %37
  %41 = load i8, ptr @conditional_var_3, align 1
  %42 = trunc i8 %41 to i1
  br i1 %42, label %43, label %44

43:                                               ; preds = %40
  br label %46

44:                                               ; preds = %40
  %45 = call i32 @__assert_fail(ptr noundef @.str.11, ptr noundef @.str.8, i32 noundef 114, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %46

46:                                               ; preds = %44, %43
  %47 = load i8, ptr @conditional_var_4, align 1
  %48 = trunc i8 %47 to i1
  br i1 %48, label %49, label %50

49:                                               ; preds = %46
  br label %52

50:                                               ; preds = %46
  %51 = call i32 @__assert_fail(ptr noundef @.str.12, ptr noundef @.str.8, i32 noundef 115, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %52

52:                                               ; preds = %50, %49
  %53 = load i8, ptr @conditional_var_5, align 1
  %54 = trunc i8 %53 to i1
  br i1 %54, label %55, label %56

55:                                               ; preds = %52
  br label %58

56:                                               ; preds = %52
  %57 = call i32 @__assert_fail(ptr noundef @.str.13, ptr noundef @.str.8, i32 noundef 116, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %58

58:                                               ; preds = %56, %55
  %59 = load i8, ptr @conditional_var_6, align 1
  %60 = trunc i8 %59 to i1
  br i1 %60, label %61, label %62

61:                                               ; preds = %58
  br label %64

62:                                               ; preds = %58
  %63 = call i32 @__assert_fail(ptr noundef @.str.14, ptr noundef @.str.8, i32 noundef 117, ptr noundef @__PRETTY_FUNCTION__.main)
  br label %64

64:                                               ; preds = %62, %61
  ret i32 0
}

; Function Attrs: alwaysinline
declare void @klee_make_symbolic(ptr noundef, i64 noundef, ptr noundef) #3

; Function Attrs: alwaysinline
declare void @klee_assume(i64 noundef) #3

; Function Attrs: alwaysinline
declare i32 @__assert_fail(...) #3

; Function Attrs: alwaysinline nounwind
declare i32 @rand() #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #6

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { alwaysinline nounwind allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #3 = { alwaysinline "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #4 = { alwaysinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #5 = { alwaysinline nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { nounwind allocsize(0) }
attributes #8 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
!6 = !{i64 955}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.mustprogress"}
