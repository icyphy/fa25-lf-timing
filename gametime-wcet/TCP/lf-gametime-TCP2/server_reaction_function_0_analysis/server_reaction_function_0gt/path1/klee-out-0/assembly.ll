; ModuleID = '/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/path1/server_reaction_function_0_klee_format_linked_inlined_mod_unrolled_mod_gvMod.bc'
source_filename = "/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/path1/server_reaction_function_0_klee_format.c"
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
@.str.8 = private unnamed_addr constant [149 x i8] c"/home/gametime/test/lf-gametime-TCP2/server_reaction_function_0_analysis/server_reaction_function_0gt/path1/server_reaction_function_0_klee_format.c\00", align 1
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
  %20 = call ptr @memcpy(ptr %11, ptr %12, i64 12)
  store ptr %0, ptr %13, align 8
  store i64 %1, ptr %14, align 8
  store i32 %2, ptr %15, align 4
  store ptr %11, ptr %16, align 8
  %21 = call noalias ptr @malloc(i64 noundef 12) #8
  store ptr %21, ptr %17, align 8
  %22 = load ptr, ptr %16, align 8
  %23 = getelementptr inbounds %struct.packet, ptr %22, i32 0, i32 0
  %24 = load i32, ptr %23, align 4
  %25 = load ptr, ptr %17, align 8
  %26 = getelementptr inbounds %struct.packet, ptr %25, i32 0, i32 0
  store i32 %24, ptr %26, align 4
  %27 = load ptr, ptr %16, align 8
  %28 = getelementptr inbounds %struct.packet, ptr %27, i32 0, i32 1
  %29 = load i32, ptr %28, align 4
  %30 = add nsw i32 %29, 1
  %31 = load ptr, ptr %17, align 8
  %32 = getelementptr inbounds %struct.packet, ptr %31, i32 0, i32 1
  store i32 %30, ptr %32, align 4
  store i8 1, ptr %18, align 1
  %33 = load i64, ptr %14, align 8
  %34 = load i32, ptr %15, align 4
  %35 = load ptr, ptr %16, align 8
  %36 = getelementptr inbounds %struct.packet, ptr %35, i32 0, i32 0
  %37 = load i32, ptr %36, align 4
  %38 = load ptr, ptr %16, align 8
  %39 = getelementptr inbounds %struct.packet, ptr %38, i32 0, i32 1
  %40 = load i32, ptr %39, align 4
  %41 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %33, i32 noundef %34, i32 noundef %37, i32 noundef %40)
  %42 = load ptr, ptr %16, align 8
  %43 = getelementptr inbounds %struct.packet, ptr %42, i32 0, i32 2
  %44 = load i32, ptr %43, align 4
  switch i32 %44, label %55 [
    i32 1, label %45
    i32 2, label %51
  ]

45:                                               ; preds = %4
  store i8 0, ptr @conditional_var_6, align 1
  %46 = load i64, ptr %14, align 8
  %47 = load i32, ptr %15, align 4
  %48 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i64 noundef %46, i32 noundef %47)
  %49 = load ptr, ptr %17, align 8
  %50 = getelementptr inbounds %struct.packet, ptr %49, i32 0, i32 2
  store i32 3, ptr %50, align 4
  br label %55

51:                                               ; preds = %4
  store i8 1, ptr @conditional_var_1, align 1
  %52 = load i64, ptr %14, align 8
  %53 = load i32, ptr %15, align 4
  %54 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i64 noundef %52, i32 noundef %53)
  store i8 0, ptr %18, align 1
  br label %55

55:                                               ; preds = %51, %45, %4
  store i8 1, ptr @conditional_var_2, align 1
  store i64 100000000, ptr %7, align 8
  %56 = call i64 asm sideeffect "rdtime $0", "=r"() #9, !srcloc !10
  store i64 %56, ptr %6, align 8
  %57 = load i64, ptr %6, align 8
  store i64 %57, ptr %8, align 8
  %58 = load i64, ptr %8, align 8
  %59 = load i64, ptr %7, align 8
  %60 = add i64 %58, %59
  store i64 %60, ptr %9, align 8
  store i8 1, ptr @conditional_var_3, align 1
  %61 = call i64 asm sideeffect "rdtime $0", "=r"() #9, !srcloc !10
  store i64 %61, ptr %5, align 8
  %62 = load i64, ptr %5, align 8
  %63 = load i64, ptr %9, align 8
  %64 = icmp ult i64 %62, %63
  br i1 %64, label %65, label %__gt_delay_for.exit

65:                                               ; preds = %55
  store i8 0, ptr @conditional_var_7, align 1
  br label %68, !llvm.loop !11

__gt_delay_for.exit:                              ; preds = %55
  %66 = load i8, ptr %18, align 1
  %67 = trunc i8 %66 to i1
  br i1 %67, label %68, label %71

68:                                               ; preds = %__gt_delay_for.exit, %65
  store i8 1, ptr @conditional_var_4, align 1
  %69 = load ptr, ptr %17, align 8
  %70 = call ptr @memcpy(ptr %10, ptr %69, i64 12)
  br label %71

71:                                               ; preds = %68, %__gt_delay_for.exit
  store i8 1, ptr @conditional_var_5, align 1
  %72 = call ptr @memcpy(ptr %19, ptr %10, i64 12)
  %73 = load [2 x i64], ptr %19, align 8
  ret [2 x i64] %73
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
  %12 = icmp eq i32 %11, 2
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  call void @klee_assume(i64 noundef %14)
  %15 = load ptr, ptr %3, align 8
  %16 = load i64, ptr %4, align 8
  %17 = load i32, ptr %5, align 4
  %18 = call ptr @memcpy(ptr %7, ptr %6, i64 12)
  %19 = load [2 x i64], ptr %7, align 8
  %20 = call [2 x i64] @_serverreaction_function_0(ptr noundef %15, i64 noundef %16, i32 noundef %17, [2 x i64] %19)
  store [2 x i64] %20, ptr %9, align 8
  %21 = call ptr @memcpy(ptr %8, ptr %9, i64 12)
  %22 = load i8, ptr @conditional_var_0, align 1
  %23 = trunc i8 %22 to i1
  br i1 %23, label %26, label %24

24:                                               ; preds = %0
  %25 = call i32 @__assert_fail(ptr noundef @.str.7, ptr noundef @.str.8, i32 noundef 113, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

26:                                               ; preds = %0
  %27 = load i8, ptr @conditional_var_1, align 1
  %28 = trunc i8 %27 to i1
  br i1 %28, label %31, label %29

29:                                               ; preds = %26
  %30 = call i32 @__assert_fail(ptr noundef @.str.9, ptr noundef @.str.8, i32 noundef 114, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

31:                                               ; preds = %26
  %32 = load i8, ptr @conditional_var_2, align 1
  %33 = trunc i8 %32 to i1
  br i1 %33, label %36, label %34

34:                                               ; preds = %31
  %35 = call i32 @__assert_fail(ptr noundef @.str.10, ptr noundef @.str.8, i32 noundef 115, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

36:                                               ; preds = %31
  %37 = load i8, ptr @conditional_var_3, align 1
  %38 = trunc i8 %37 to i1
  br i1 %38, label %41, label %39

39:                                               ; preds = %36
  %40 = call i32 @__assert_fail(ptr noundef @.str.11, ptr noundef @.str.8, i32 noundef 116, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

41:                                               ; preds = %36
  %42 = load i8, ptr @conditional_var_4, align 1
  %43 = trunc i8 %42 to i1
  br i1 %43, label %46, label %44

44:                                               ; preds = %41
  %45 = call i32 @__assert_fail(ptr noundef @.str.12, ptr noundef @.str.8, i32 noundef 117, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

46:                                               ; preds = %41
  %47 = load i8, ptr @conditional_var_5, align 1
  %48 = trunc i8 %47 to i1
  br i1 %48, label %51, label %49

49:                                               ; preds = %46
  %50 = call i32 @__assert_fail(ptr noundef @.str.13, ptr noundef @.str.8, i32 noundef 118, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

51:                                               ; preds = %46
  %52 = load i8, ptr @conditional_var_6, align 1
  %53 = trunc i8 %52 to i1
  br i1 %53, label %56, label %54

54:                                               ; preds = %51
  %55 = call i32 @__assert_fail(ptr noundef @.str.14, ptr noundef @.str.8, i32 noundef 119, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

56:                                               ; preds = %51
  %57 = load i8, ptr @conditional_var_7, align 1
  %58 = trunc i8 %57 to i1
  br i1 %58, label %61, label %59

59:                                               ; preds = %56
  %60 = call i32 @__assert_fail(ptr noundef @.str.15, ptr noundef @.str.8, i32 noundef 120, ptr noundef @__PRETTY_FUNCTION__.main)
  unreachable

61:                                               ; preds = %56
  ret i32 0
}

; Function Attrs: alwaysinline
declare void @klee_make_symbolic(ptr noundef, i64 noundef, ptr noundef) #3

; Function Attrs: alwaysinline
declare void @klee_assume(i64 noundef) #3

; Function Attrs: alwaysinline noreturn
declare i32 @__assert_fail(...) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: noinline nounwind uwtable
define dso_local ptr @memcpy(ptr noundef %0, ptr noundef %1, i64 noundef %2) #0 !dbg !13 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !24, metadata !DIExpression()), !dbg !25
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !26, metadata !DIExpression()), !dbg !27
  store i64 %2, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !28, metadata !DIExpression()), !dbg !29
  call void @llvm.dbg.declare(metadata ptr %7, metadata !30, metadata !DIExpression()), !dbg !33
  %9 = load ptr, ptr %4, align 8, !dbg !34
  store ptr %9, ptr %7, align 8, !dbg !33
  call void @llvm.dbg.declare(metadata ptr %8, metadata !35, metadata !DIExpression()), !dbg !38
  %10 = load ptr, ptr %5, align 8, !dbg !39
  store ptr %10, ptr %8, align 8, !dbg !38
  br label %11, !dbg !40

11:                                               ; preds = %15, %3
  %12 = load i64, ptr %6, align 8, !dbg !41
  %13 = add i64 %12, -1, !dbg !41
  store i64 %13, ptr %6, align 8, !dbg !41
  %14 = icmp ugt i64 %12, 0, !dbg !42
  br i1 %14, label %15, label %21, !dbg !40

15:                                               ; preds = %11
  %16 = load ptr, ptr %8, align 8, !dbg !43
  %17 = getelementptr inbounds i8, ptr %16, i32 1, !dbg !43
  store ptr %17, ptr %8, align 8, !dbg !43
  %18 = load i8, ptr %16, align 1, !dbg !44
  %19 = load ptr, ptr %7, align 8, !dbg !45
  %20 = getelementptr inbounds i8, ptr %19, i32 1, !dbg !45
  store ptr %20, ptr %7, align 8, !dbg !45
  store i8 %18, ptr %19, align 1, !dbg !46
  br label %11, !dbg !40, !llvm.loop !47

21:                                               ; preds = %11
  %22 = load ptr, ptr %4, align 8, !dbg !48
  ret ptr %22, !dbg !49
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #7

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { alwaysinline nounwind allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #3 = { alwaysinline "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #4 = { alwaysinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #5 = { alwaysinline noreturn "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nounwind allocsize(0) }
attributes #9 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.ident = !{!7, !7}
!llvm.dbg.cu = !{!8}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{i32 7, !"Dwarf Version", i32 5}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
!8 = distinct !DICompileUnit(language: DW_LANG_C11, file: !9, producer: "Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!9 = !DIFile(filename: "/tmp/klee/runtime/Freestanding/memcpy.c", directory: "/tmp/klee/build/runtime/Freestanding", checksumkind: CSK_MD5, checksum: "c636d77d986b2156da8c1ff12af1c5cd")
!10 = !{i64 985}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.mustprogress"}
!13 = distinct !DISubprogram(name: "memcpy", scope: !14, file: !14, line: 12, type: !15, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !8, retainedNodes: !23)
!14 = !DIFile(filename: "runtime/Freestanding/memcpy.c", directory: "/tmp/klee", checksumkind: CSK_MD5, checksum: "c636d77d986b2156da8c1ff12af1c5cd")
!15 = !DISubroutineType(types: !16)
!16 = !{!17, !17, !18, !20}
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !21, line: 46, baseType: !22)
!21 = !DIFile(filename: "/usr/lib/llvm-16/lib/clang/16/include/stddef.h", directory: "", checksumkind: CSK_MD5, checksum: "f95079da609b0e8f201cb8136304bf3b")
!22 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!23 = !{}
!24 = !DILocalVariable(name: "destaddr", arg: 1, scope: !13, file: !14, line: 12, type: !17)
!25 = !DILocation(line: 12, column: 20, scope: !13)
!26 = !DILocalVariable(name: "srcaddr", arg: 2, scope: !13, file: !14, line: 12, type: !18)
!27 = !DILocation(line: 12, column: 42, scope: !13)
!28 = !DILocalVariable(name: "len", arg: 3, scope: !13, file: !14, line: 12, type: !20)
!29 = !DILocation(line: 12, column: 58, scope: !13)
!30 = !DILocalVariable(name: "dest", scope: !13, file: !14, line: 13, type: !31)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!32 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_unsigned_char)
!33 = !DILocation(line: 13, column: 9, scope: !13)
!34 = !DILocation(line: 13, column: 16, scope: !13)
!35 = !DILocalVariable(name: "src", scope: !13, file: !14, line: 14, type: !36)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !32)
!38 = !DILocation(line: 14, column: 15, scope: !13)
!39 = !DILocation(line: 14, column: 21, scope: !13)
!40 = !DILocation(line: 16, column: 3, scope: !13)
!41 = !DILocation(line: 16, column: 13, scope: !13)
!42 = !DILocation(line: 16, column: 16, scope: !13)
!43 = !DILocation(line: 17, column: 19, scope: !13)
!44 = !DILocation(line: 17, column: 15, scope: !13)
!45 = !DILocation(line: 17, column: 10, scope: !13)
!46 = !DILocation(line: 17, column: 13, scope: !13)
!47 = distinct !{!47, !40, !43, !12}
!48 = !DILocation(line: 18, column: 10, scope: !13)
!49 = !DILocation(line: 18, column: 3, scope: !13)
