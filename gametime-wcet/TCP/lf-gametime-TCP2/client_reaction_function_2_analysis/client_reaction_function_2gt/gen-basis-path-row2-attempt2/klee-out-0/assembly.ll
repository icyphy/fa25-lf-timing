; ModuleID = '/home/gametime/test/lf-gametime-TCP2/client_reaction_function_2_analysis/client_reaction_function_2gt/gen-basis-path-row2-attempt2/client_reaction_function_2_klee_format_linked_inlined_mod_unrolled_mod_gvMod.bc'
source_filename = "/home/gametime/test/lf-gametime-TCP2/client_reaction_function_2_analysis/client_reaction_function_2gt/gen-basis-path-row2-attempt2/client_reaction_function_2_klee_format.c"
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
@.str = private unnamed_addr constant [52 x i8] c"(%lld, %d) [CLIENT] Received packet (*id)=%d seq=%d\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"[CLIENT] Received SYN-ACK\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"period_val\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"id_val\00", align 1
@.str.4 = private unnamed_addr constant [24 x i8] c"__symbolic_elapsed_time\00", align 1
@.str.5 = private unnamed_addr constant [21 x i8] c"__symbolic_microstep\00", align 1
@.str.6 = private unnamed_addr constant [4 x i8] c"inp\00", align 1
@.str.7 = private unnamed_addr constant [18 x i8] c"conditional_var_0\00", align 1
@.str.8 = private unnamed_addr constant [172 x i8] c"/home/gametime/test/lf-gametime-TCP2/client_reaction_function_2_analysis/client_reaction_function_2gt/gen-basis-path-row2-attempt2/client_reaction_function_2_klee_format.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str.9 = private unnamed_addr constant [18 x i8] c"conditional_var_1\00", align 1
@.str.10 = private unnamed_addr constant [18 x i8] c"conditional_var_2\00", align 1
@.str.11 = private unnamed_addr constant [18 x i8] c"conditional_var_3\00", align 1
@.str.12 = private unnamed_addr constant [18 x i8] c"conditional_var_4\00", align 1
@.str.13 = private unnamed_addr constant [18 x i8] c"conditional_var_5\00", align 1
@.str.14 = private unnamed_addr constant [18 x i8] c"conditional_var_6\00", align 1
@.str.15 = private unnamed_addr constant [50 x i8] c"/tmp/klee/runtime/Intrinsic/klee_div_zero_check.c\00", align 1, !dbg !0
@.str.1.16 = private unnamed_addr constant [15 x i8] c"divide by zero\00", align 1, !dbg !8
@.str.2.17 = private unnamed_addr constant [8 x i8] c"div.err\00", align 1, !dbg !13

; Function Attrs: noinline nounwind uwtable
define dso_local [2 x i64] @_clientreaction_function_2(ptr noundef %0, ptr noundef %1, i64 noundef %2, i32 noundef %3, [2 x i64] %4) #0 {
  store i8 1, ptr @conditional_var_0, align 1
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
  %24 = call ptr @memcpy(ptr %14, ptr %15, i64 12)
  store ptr %0, ptr %16, align 8
  store ptr %1, ptr %17, align 8
  store i64 %2, ptr %18, align 8
  store i32 %3, ptr %19, align 4
  store ptr %14, ptr %20, align 8
  %25 = call noalias ptr @malloc(i64 noundef 12) #10
  store ptr %25, ptr %21, align 8
  %26 = load ptr, ptr %20, align 8
  %27 = getelementptr inbounds %struct.packet, ptr %26, i32 0, i32 0
  %28 = load i32, ptr %27, align 4
  %29 = load ptr, ptr %21, align 8
  %30 = getelementptr inbounds %struct.packet, ptr %29, i32 0, i32 0
  store i32 %28, ptr %30, align 4
  %31 = load ptr, ptr %20, align 8
  %32 = getelementptr inbounds %struct.packet, ptr %31, i32 0, i32 1
  %33 = load i32, ptr %32, align 4
  %34 = add nsw i32 %33, 1
  %35 = load ptr, ptr %21, align 8
  %36 = getelementptr inbounds %struct.packet, ptr %35, i32 0, i32 1
  store i32 %34, ptr %36, align 4
  store i8 1, ptr %22, align 1
  %37 = load i64, ptr %18, align 8
  %38 = load i32, ptr %19, align 4
  %39 = load ptr, ptr %20, align 8
  %40 = getelementptr inbounds %struct.packet, ptr %39, i32 0, i32 0
  %41 = load i32, ptr %40, align 4
  %42 = load ptr, ptr %20, align 8
  %43 = getelementptr inbounds %struct.packet, ptr %42, i32 0, i32 1
  %44 = load i32, ptr %43, align 4
  %45 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %37, i32 noundef %38, i32 noundef %41, i32 noundef %44)
  %46 = load ptr, ptr %20, align 8
  %47 = getelementptr inbounds %struct.packet, ptr %46, i32 0, i32 2
  %48 = load i32, ptr %47, align 4
  %cond = icmp eq i32 %48, 3
  br i1 %cond, label %49, label %55

49:                                               ; preds = %5
  store i8 1, ptr @conditional_var_1, align 1
  %50 = load i64, ptr %18, align 8
  %51 = load i32, ptr %19, align 4
  %52 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %50, i32 noundef %51)
  %53 = load ptr, ptr %21, align 8
  %54 = getelementptr inbounds %struct.packet, ptr %53, i32 0, i32 2
  store i32 2, ptr %54, align 4
  br label %55

55:                                               ; preds = %5, %49
  store i8 1, ptr @conditional_var_2, align 1
  store i32 40, ptr %8, align 4
  store i32 60, ptr %9, align 4
  %56 = call i32 @rand() #11
  %57 = load i32, ptr %9, align 4
  %58 = load i32, ptr %8, align 4
  %59 = sub nsw i32 %57, %58
  %60 = add nsw i32 %59, 1
  %int_cast_to_i64 = zext i32 %60 to i64
  call void @klee_div_zero_check(i64 %int_cast_to_i64)
  %61 = srem i32 %56, %60, !klee.check.div !31
  %62 = load i32, ptr %8, align 4
  %63 = add nsw i32 %61, %62
  %64 = sext i32 %63 to i64
  %65 = mul nsw i64 %64, 1000000
  store i64 %65, ptr %10, align 8
  %66 = call i64 asm sideeffect "rdtime $0", "=r"() #11, !srcloc !32
  store i64 %66, ptr %7, align 8
  %67 = load i64, ptr %7, align 8
  store i64 %67, ptr %11, align 8
  %68 = load i64, ptr %11, align 8
  %69 = load i64, ptr %10, align 8
  %70 = add i64 %68, %69
  store i64 %70, ptr %12, align 8
  store i8 1, ptr @conditional_var_3, align 1
  %71 = call i64 asm sideeffect "rdtime $0", "=r"() #11, !srcloc !32
  store i64 %71, ptr %6, align 8
  %72 = load i64, ptr %6, align 8
  %73 = load i64, ptr %12, align 8
  %74 = icmp ult i64 %72, %73
  br i1 %74, label %75, label %__gt_delay_for.exit

75:                                               ; preds = %55
  store i8 0, ptr @conditional_var_6, align 1
  br label %78, !llvm.loop !33

__gt_delay_for.exit:                              ; preds = %55
  %76 = load i8, ptr %22, align 1
  %77 = trunc i8 %76 to i1
  br i1 %77, label %78, label %81

78:                                               ; preds = %__gt_delay_for.exit, %75
  store i8 1, ptr @conditional_var_4, align 1
  %79 = load ptr, ptr %21, align 8
  %80 = call ptr @memcpy(ptr %13, ptr %79, i64 12)
  br label %81

81:                                               ; preds = %78, %__gt_delay_for.exit
  store i8 1, ptr @conditional_var_5, align 1
  %82 = call ptr @memcpy(ptr %23, ptr %13, i64 12)
  %83 = load [2 x i64], ptr %23, align 8
  ret [2 x i64] %83
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
  %21 = call ptr @memcpy(ptr %9, ptr %8, i64 12)
  %22 = load [2 x i64], ptr %9, align 8
  %23 = call [2 x i64] @_clientreaction_function_2(ptr noundef %17, ptr noundef %18, i64 noundef %19, i32 noundef %20, [2 x i64] %22)
  store [2 x i64] %23, ptr %11, align 8
  %24 = call ptr @memcpy(ptr %10, ptr %11, i64 12)
  %25 = load i8, ptr @conditional_var_0, align 1
  %26 = trunc i8 %25 to i1
  br i1 %26, label %29, label %27

27:                                               ; preds = %0
  %28 = call i32 @__assert_fail(ptr noundef @.str.7, ptr noundef @.str.8, i32 noundef 111, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

29:                                               ; preds = %0
  %30 = load i8, ptr @conditional_var_1, align 1
  %31 = trunc i8 %30 to i1
  br i1 %31, label %34, label %32

32:                                               ; preds = %29
  %33 = call i32 @__assert_fail(ptr noundef @.str.9, ptr noundef @.str.8, i32 noundef 112, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

34:                                               ; preds = %29
  %35 = load i8, ptr @conditional_var_2, align 1
  %36 = trunc i8 %35 to i1
  br i1 %36, label %39, label %37

37:                                               ; preds = %34
  %38 = call i32 @__assert_fail(ptr noundef @.str.10, ptr noundef @.str.8, i32 noundef 113, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

39:                                               ; preds = %34
  %40 = load i8, ptr @conditional_var_3, align 1
  %41 = trunc i8 %40 to i1
  br i1 %41, label %44, label %42

42:                                               ; preds = %39
  %43 = call i32 @__assert_fail(ptr noundef @.str.11, ptr noundef @.str.8, i32 noundef 114, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

44:                                               ; preds = %39
  %45 = load i8, ptr @conditional_var_4, align 1
  %46 = trunc i8 %45 to i1
  br i1 %46, label %49, label %47

47:                                               ; preds = %44
  %48 = call i32 @__assert_fail(ptr noundef @.str.12, ptr noundef @.str.8, i32 noundef 115, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

49:                                               ; preds = %44
  %50 = load i8, ptr @conditional_var_5, align 1
  %51 = trunc i8 %50 to i1
  br i1 %51, label %54, label %52

52:                                               ; preds = %49
  %53 = call i32 @__assert_fail(ptr noundef @.str.13, ptr noundef @.str.8, i32 noundef 116, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

54:                                               ; preds = %49
  %55 = load i8, ptr @conditional_var_6, align 1
  %56 = trunc i8 %55 to i1
  br i1 %56, label %59, label %57

57:                                               ; preds = %54
  %58 = call i32 @__assert_fail(ptr noundef @.str.14, ptr noundef @.str.8, i32 noundef 117, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

59:                                               ; preds = %54
  ret i32 0
}

; Function Attrs: alwaysinline
declare void @klee_make_symbolic(ptr noundef, i64 noundef, ptr noundef) #3

; Function Attrs: alwaysinline
declare void @klee_assume(i64 noundef) #3

; Function Attrs: alwaysinline noreturn
declare i32 @__assert_fail(...) #5

; Function Attrs: alwaysinline nounwind
declare i32 @rand() #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #7

; Function Attrs: noinline nounwind uwtable
define dso_local ptr @memcpy(ptr noundef %0, ptr noundef %1, i64 noundef %2) #0 !dbg !35 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !46, metadata !DIExpression()), !dbg !47
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !48, metadata !DIExpression()), !dbg !49
  store i64 %2, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !50, metadata !DIExpression()), !dbg !51
  call void @llvm.dbg.declare(metadata ptr %7, metadata !52, metadata !DIExpression()), !dbg !54
  %9 = load ptr, ptr %4, align 8, !dbg !55
  store ptr %9, ptr %7, align 8, !dbg !54
  call void @llvm.dbg.declare(metadata ptr %8, metadata !56, metadata !DIExpression()), !dbg !58
  %10 = load ptr, ptr %5, align 8, !dbg !59
  store ptr %10, ptr %8, align 8, !dbg !58
  br label %11, !dbg !60

11:                                               ; preds = %15, %3
  %12 = load i64, ptr %6, align 8, !dbg !61
  %13 = add i64 %12, -1, !dbg !61
  store i64 %13, ptr %6, align 8, !dbg !61
  %14 = icmp ugt i64 %12, 0, !dbg !62
  br i1 %14, label %15, label %21, !dbg !60

15:                                               ; preds = %11
  %16 = load ptr, ptr %8, align 8, !dbg !63
  %17 = getelementptr inbounds i8, ptr %16, i32 1, !dbg !63
  store ptr %17, ptr %8, align 8, !dbg !63
  %18 = load i8, ptr %16, align 1, !dbg !64
  %19 = load ptr, ptr %7, align 8, !dbg !65
  %20 = getelementptr inbounds i8, ptr %19, i32 1, !dbg !65
  store ptr %20, ptr %7, align 8, !dbg !65
  store i8 %18, ptr %19, align 1, !dbg !66
  br label %11, !dbg !60, !llvm.loop !67

21:                                               ; preds = %11
  %22 = load ptr, ptr %4, align 8, !dbg !68
  ret ptr %22, !dbg !69
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #8

; Function Attrs: noinline nounwind uwtable
define dso_local void @klee_div_zero_check(i64 noundef %0) #0 !dbg !70 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !74, metadata !DIExpression()), !dbg !75
  %3 = load i64, ptr %2, align 8, !dbg !76
  %4 = icmp eq i64 %3, 0, !dbg !78
  br i1 %4, label %5, label %6, !dbg !79

5:                                                ; preds = %1
  call void @klee_report_error(ptr noundef @.str.15, i32 noundef 14, ptr noundef @.str.1.16, ptr noundef @.str.2.17) #12, !dbg !80
  unreachable, !dbg !80

6:                                                ; preds = %1
  ret void, !dbg !81
}

; Function Attrs: noreturn
declare void @klee_report_error(ptr noundef, i32 noundef, ptr noundef, ptr noundef) #9

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { alwaysinline nounwind allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #3 = { alwaysinline "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #4 = { alwaysinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #5 = { alwaysinline noreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #6 = { alwaysinline nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { noreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #10 = { nounwind allocsize(0) }
attributes #11 = { nounwind }
attributes #12 = { noreturn }

!llvm.module.flags = !{!18, !19, !20, !21, !22, !23, !24}
!llvm.ident = !{!25, !25, !25}
!llvm.dbg.cu = !{!26, !28}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 14, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "runtime/Intrinsic/klee_div_zero_check.c", directory: "/tmp/klee", checksumkind: CSK_MD5, checksum: "ac97458b4bebcea5cefe50ebb216db13")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 400, elements: !6)
!4 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5)
!5 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_unsigned_char)
!6 = !{!7}
!7 = !DISubrange(count: 50)
!8 = !DIGlobalVariableExpression(var: !9, expr: !DIExpression())
!9 = distinct !DIGlobalVariable(scope: null, file: !2, line: 14, type: !10, isLocal: true, isDefinition: true)
!10 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 120, elements: !11)
!11 = !{!12}
!12 = !DISubrange(count: 15)
!13 = !DIGlobalVariableExpression(var: !14, expr: !DIExpression())
!14 = distinct !DIGlobalVariable(scope: null, file: !2, line: 14, type: !15, isLocal: true, isDefinition: true)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 64, elements: !16)
!16 = !{!17}
!17 = !DISubrange(count: 8)
!18 = !{i32 1, !"wchar_size", i32 4}
!19 = !{i32 8, !"PIC Level", i32 2}
!20 = !{i32 7, !"PIE Level", i32 2}
!21 = !{i32 7, !"uwtable", i32 2}
!22 = !{i32 7, !"frame-pointer", i32 1}
!23 = !{i32 7, !"Dwarf Version", i32 5}
!24 = !{i32 2, !"Debug Info Version", i32 3}
!25 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
!26 = distinct !DICompileUnit(language: DW_LANG_C11, file: !27, producer: "Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!27 = !DIFile(filename: "/tmp/klee/runtime/Freestanding/memcpy.c", directory: "/tmp/klee/build/runtime/Freestanding", checksumkind: CSK_MD5, checksum: "c636d77d986b2156da8c1ff12af1c5cd")
!28 = distinct !DICompileUnit(language: DW_LANG_C89, file: !29, producer: "Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !30, splitDebugInlining: false, nameTableKind: None)
!29 = !DIFile(filename: "/tmp/klee/runtime/Intrinsic/klee_div_zero_check.c", directory: "/tmp/klee/build/runtime/Intrinsic", checksumkind: CSK_MD5, checksum: "ac97458b4bebcea5cefe50ebb216db13")
!30 = !{!0, !8, !13}
!31 = !{!"True"}
!32 = !{i64 954}
!33 = distinct !{!33, !34}
!34 = !{!"llvm.loop.mustprogress"}
!35 = distinct !DISubprogram(name: "memcpy", scope: !36, file: !36, line: 12, type: !37, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !26, retainedNodes: !45)
!36 = !DIFile(filename: "runtime/Freestanding/memcpy.c", directory: "/tmp/klee", checksumkind: CSK_MD5, checksum: "c636d77d986b2156da8c1ff12af1c5cd")
!37 = !DISubroutineType(types: !38)
!38 = !{!39, !39, !40, !42}
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!41 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!42 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !43, line: 46, baseType: !44)
!43 = !DIFile(filename: "/usr/lib/llvm-16/lib/clang/16/include/stddef.h", directory: "", checksumkind: CSK_MD5, checksum: "f95079da609b0e8f201cb8136304bf3b")
!44 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!45 = !{}
!46 = !DILocalVariable(name: "destaddr", arg: 1, scope: !35, file: !36, line: 12, type: !39)
!47 = !DILocation(line: 12, column: 20, scope: !35)
!48 = !DILocalVariable(name: "srcaddr", arg: 2, scope: !35, file: !36, line: 12, type: !40)
!49 = !DILocation(line: 12, column: 42, scope: !35)
!50 = !DILocalVariable(name: "len", arg: 3, scope: !35, file: !36, line: 12, type: !42)
!51 = !DILocation(line: 12, column: 58, scope: !35)
!52 = !DILocalVariable(name: "dest", scope: !35, file: !36, line: 13, type: !53)
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!54 = !DILocation(line: 13, column: 9, scope: !35)
!55 = !DILocation(line: 13, column: 16, scope: !35)
!56 = !DILocalVariable(name: "src", scope: !35, file: !36, line: 14, type: !57)
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!58 = !DILocation(line: 14, column: 15, scope: !35)
!59 = !DILocation(line: 14, column: 21, scope: !35)
!60 = !DILocation(line: 16, column: 3, scope: !35)
!61 = !DILocation(line: 16, column: 13, scope: !35)
!62 = !DILocation(line: 16, column: 16, scope: !35)
!63 = !DILocation(line: 17, column: 19, scope: !35)
!64 = !DILocation(line: 17, column: 15, scope: !35)
!65 = !DILocation(line: 17, column: 10, scope: !35)
!66 = !DILocation(line: 17, column: 13, scope: !35)
!67 = distinct !{!67, !60, !63, !34}
!68 = !DILocation(line: 18, column: 10, scope: !35)
!69 = !DILocation(line: 18, column: 3, scope: !35)
!70 = distinct !DISubprogram(name: "klee_div_zero_check", scope: !2, file: !2, line: 12, type: !71, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !28, retainedNodes: !45)
!71 = !DISubroutineType(types: !72)
!72 = !{null, !73}
!73 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!74 = !DILocalVariable(name: "z", arg: 1, scope: !70, file: !2, line: 12, type: !73)
!75 = !DILocation(line: 12, column: 36, scope: !70)
!76 = !DILocation(line: 13, column: 7, scope: !77)
!77 = distinct !DILexicalBlock(scope: !70, file: !2, line: 13, column: 7)
!78 = !DILocation(line: 13, column: 9, scope: !77)
!79 = !DILocation(line: 13, column: 7, scope: !70)
!80 = !DILocation(line: 14, column: 5, scope: !77)
!81 = !DILocation(line: 15, column: 1, scope: !70)
