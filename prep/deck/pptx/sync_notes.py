"""Keep speech, slide cues and click counts in one source of truth."""
from pathlib import Path
import html, json, re
ROOT=Path(__file__).resolve().parents[3]
D=ROOT/'prep/deck/hardfest'
deck=json.loads((D/'deck.json').read_text())
text=(ROOT/'prep/script/full_script.md').read_text()
chunks=re.findall(r'^### \d+\. `([^`]+)`[^\n]*\n(.*?)(?=^### \d+\. |\Z)',text,re.M|re.S)
chunks=dict(chunks)
source={
 'cover':'Материалы доклада: https://github.com/Neoron95/conference-hardfest-algorithms . Кейс обезличен, детали упрощены; эксперименты на тестовых данных.',
 'diff':'Публичный пример кода. В эксперименте reserve добавлен; производственный результат не заявляется.',
 'case':'Самостоятельная упрощённая задача: L sorted unique; D может содержать повторы; числовые id. Отдельные тестовые серии фиксируют другие свойства входа.',
 'vote':'Базовая серия: N=U=2^20, случайные uint64_t, порядок результата не важен. O(n) — средняя оценка unordered_set.',
 'result':'prep/research/apple.md; prep/research/bench.md. Mac M2 Pro, libc++; N=U=2^20. Полная операция. Атрибуция: https://lemire.me/blog/2017/05/23/counting-exactly-the-number-of-distinct-elements-sorted-arrays-vs-hash-sets/ ; Chandler Carruth, CppCon 2014, Efficiency with Algorithms, Performance with Data Structures.',
 'contract':'bench/dedup_bench.cpp и bench/results/summary.md. Копирование входа вне таймера; reserve, insert, output и деструктор внутри; проверка результата вне таймера.',
 'curve':'prep/research/apple.md; исходная серия curve, M2 Pro, U/N=0,5. Рабочий набор: таблица примерно12/24 МиБ плюс вход4/8 МиБ на 512K/1M. L2 16 МиБ общий для кластера P. Излом — косвенное свидетельство; резидентность и вклад промахов кэша не измерены напрямую.',
 'nodes':'bench/results/summary.md, E6; prep/research/cpp.md. N=U=2^20; счётчики аллокаций и суммы запросов аллокатору отличаются от RSS. Размер узла зависит от стандартной библиотеки.',
 'memory':'prep/research/apple.md; Ulrich Drepper, What Every Programmer Should Know About Memory, §3.3.2: https://people.freebsd.org/~lstewart/articles/cpumemory.pdf . Иллюстрация зависимости адресов, не измеренная декомпозиция ускорения сортировки.',
 'flatmin':'prep/research/cpp.md §5; Abseil Swiss Tables design: https://abseil.io/about/design/swisstables ; Matt Kulukundis, CppCon 2017. Диаграмма организации таблицы; SIMD-группы зависят от архитектуры.',
 'flat':'prep/research/apple.md; Mac M2 Pro, libc++; N=U=2^20:19,9/51,3/11,7/6,9нс/элемент. ×1,7 — flat против sort. Radix — отдельная реализация для uint64_t.',
 'share-q':'Доля уникальных относится к тестовым входам; свойства реальных пользователей не заявляются.',
 'share':'Исходная серия доли уникальных, Mac M2 Pro, N=2^20. U/N=1%:sort12,0,unordered3,2;100%:sort19,8,unordered51,6нс/элемент. Reserve(N) фиксирован: при малом U массив бакетов остаётся большим. Полная серия в share-full.',
 'outcontract':'prep/research/apple.md и cpp.md §9. Mac M2 Pro,N=2^20,U/N=0,5. Первое появление: дляsort пары(ключ,индекс) и вторая сортировка; это конкретный вариант, не нижняя граница дляsort. Порядок обходаset не часть контракта.',
 'inputorder':'prep/research/apple.md; bench/results/summary.md,E4. Mac M2 Pro,libc++;N=2^20,U/N=0,5. Перестановки одинаковых ключей и кратностей. Эвристика std::sort зависит от библиотеки; коэффициент не универсален.',
 'learned':'bench/results/summary.md,E5; prep/research/apple.md. M2 native macOS6,8/14,4 — наблюдение; контроль с одинаковыми копиями на M2 выполнен в Linux VM. Нельзя считать его контролем нативной macOS. На x86 контрольE5 дополнен одним буфером 8 КиБ. Гипотезы не приписываются чипу как установленная причина.',
 'qos':'prep/research/apple.md §5–6. API pthread_set_qos_class_self_np; N=2^19,U/N=0,5. iPhone 14 Pro,A16 Bionic. ВысокийQoS19,6/18,2;utility55,3/105,3нс/элемент: смена лидера на 512K. Mac M2 Pro при 1M: изменения разрыва×1,3/×1,8. SwiftTask не измерялся. SE-0304: https://github.com/swiftlang/swift-evolution/blob/main/proposals/0304-structured-concurrency.md . Task может наследовать actor isolation; await может повысить приоритет.',
 'x33':'Исходная серия iPhone 14 Pro,A16 Bionic,pthreadQoS utility,N=2^20,U/N=0,5. sort57,4/uset187,7нс/элемент;187,7/57,4=3,27≈3,3. Парная серия другогоQoS на 1M здесь не заявлена. Модель: https://support.apple.com/en-my/111849 .',
 'core-model':'Объясняющая схема. Размеркэша может сдвигать границу; частота особенно влияет на высоту внутриL1/L2, дляDRAM простая пропорция неприменима. P/E-модельiPhone 14 Pro: https://support.apple.com/en-my/111849 .',
 'cores':'prep/research/apple.md §1–2; методDrepper. Отдельный pointer-chasing тест. Изломы — косвенный признак типа ядра, не CPU-трасса дедупа. userInitiated не равно foreground приложения. Версия iOS и размеры кэшей телефона не подставлены. iPhone utility содержит фактические особенности исходной линии.',
 'flip':'bench/results/summary.md,E2 и E2b; prep/research/apple.md. x86/Linux/libstdc++: повтор1,64/1,29/1,12/≈1,02(sort/uset) на 64K/256K/512K/1M. M2, libc++ и iPhone utility — исходные серии. Таблица рейтингов внутри машин, не общей скорости платформ.',
 'merge':'bench/results/summary.md,E8; bench/dedup_bench.cpp. L=2^20sorted unique,D=2^16,U/N delta=0,5. Δ sort+unique перед set_union. ×3,5–6,6 — разные библиотечные связки x86, не серия наiPhone.',
 'prod':'Лабораторная оценка из qos/x33:55,3×2^19≈29мс;105,3×2^19≈55мс;57,4×2^20≈60мс;187,7×2^20≈197мс. +12 МиБ — оценка структуры таблицы, не измеренный RSS. Не вся синхронизация и не продуктовый выкат.',
 'platforms':'Применение метода, без новых измерений. prep/research/beyond.md; SE-0304. Контейнеры, actor isolation, executor и QoS различаются. CPU в CI не обязан повторять целевую платформу.',
 'review':'Возврат к исходному публичному дифу. Пауза 5 секунд на собственный комментарий. Выводы привязаны к контракту, данным и окружению.',
 'final':'QR: https://github.com/Neoron95/conference-hardfest-algorithms .'}
expected=[0,2,3,2,3,0,3,2,2,3,3,2,2,3,3,2,3,2,2,3,3,2,2,2,4,1]
for n,id in enumerate(deck['order'][:deck['mainCount']]):
 c=chunks[id]
 speech=re.search(r'\*\*Говорю\.\*\*\s*(.*?)(?=\*\*Если отстаю)',c,re.S).group(1)
 clicks=speech.count('[щелчок]')
 p=D/'slides'/f'{id}.html';s=p.read_text()
 body=s.split('<aside>')[0];orders=sorted(set(map(int,re.findall(r'data-build-in="\w+ (\d+)"',body))))
 assert clicks==expected[n],(id,'speech',clicks,expected[n])
 assert orders==list(range(1,clicks+1)),(id,'build',orders,clicks)
 # Every note starts with the same cue/text as the authoritative script.
 note=f'Слайд {n+1}: {id}\n'+c.strip()+f'\n\nИсточники и условия.\n{source[id]}\n'
 note=re.sub(r'\*\*([^*]+)\*\*',r'\1',note).replace('`','')
 encoded=html.escape(note,quote=False).replace('\n','<br>')
 s=re.sub(r'<aside>.*?</aside>','<aside>'+encoded+'</aside>',s,flags=re.S)
 p.write_text(s)
print(f'Synced {deck["mainCount"]} main slides, {sum(expected)} click steps')
# Optional modules are static slides, each self-contained with transitions.
m=(ROOT/'prep/script/modules.md').read_text()
for id,c in re.findall(r'^## \d+\. `([^`]+)`[^\n]*\n(.*?)(?=^## |\Z)',m,re.M|re.S):
 p=D/'slides'/f'{id}.html';s=p.read_text();notes='Модуль '+id+'\n'+c.strip()+'\nИсточники: prep/research/bench.md; cpp.md; apple.md; beyond.md; bench/results/summary.md.'
 notes=re.sub(r'\*\*([^*]+)\*\*',r'\1',notes).replace('`','')
 s=re.sub(r'<aside>.*?</aside>','<aside>'+html.escape(notes,quote=False).replace('\n','<br>')+'</aside>',s,flags=re.S);p.write_text(s)
